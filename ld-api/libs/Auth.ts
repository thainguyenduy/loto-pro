import {
  applyDecorators,
  CanActivate,
  ExecutionContext,
  Inject,
  UseGuards,
  UnauthorizedException,
} from '@nestjs/common';
import { ApiBasicAuth, ApiForbiddenResponse } from '@nestjs/swagger';
import { Request } from 'express';

import {
  EntityIdTransformer,
  ENTITY_ID_TRANSFORMER,
  readConnection,
} from 'libs/DatabaseModule';

import { JwtService } from '@nestjs/jwt';
import { ConfigService } from '@nestjs/config';
import { AccountEntity } from 'src/account/infrastructure/entity/AccountEntity';
class AuthGuard implements CanActivate {
  @Inject(ENTITY_ID_TRANSFORMER)
  private readonly entityIdTransformer: EntityIdTransformer;
  @Inject() private readonly configService: ConfigService;
  constructor(private jwtService: JwtService) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const authorization = context
      .switchToHttp()
      .getRequest<Request>()
      .header('authorization');
    if (!authorization) return false;

    const request = context.switchToHttp().getRequest();
    const token = this.extractTokenFromHeader(request);
    if (!token) {
      throw new UnauthorizedException();
    }
    try {
      const payload = await this.jwtService.verifyAsync(token, {
        secret: this.configService.get<string>('SECRET_KEY'),
      });

      const account = await readConnection
        .getRepository(AccountEntity)
        .findOneBy({
          id: this.entityIdTransformer.to(payload.accountId),
          deviceId: payload.deviceId,
        });
      if (!account) throw new UnauthorizedException();
      // 💡 We're assigning the payload to the request object here
      // so that we can access it in our route handlers
      request['user'] = payload;
    } catch {
      throw new UnauthorizedException();
    }
    return true;
  }
  private extractTokenFromHeader(request: Request): string | undefined {
    const [type, token] = request.headers.authorization?.split(' ') ?? [];
    return type === 'Bearer' ? token : undefined;
  }
}

export type AuthorizedHeader = Readonly<{ accountId: string }>;

export const Auth = () =>
  applyDecorators(
    UseGuards(AuthGuard),
    ApiBasicAuth(),
    ApiForbiddenResponse({
      description: 'Authorization header validation is failed',
    }),
  );
