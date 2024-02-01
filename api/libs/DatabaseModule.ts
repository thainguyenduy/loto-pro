import {
  Global,
  Injectable,
  Module,
  OnModuleDestroy,
  OnModuleInit,
} from '@nestjs/common';
import {
  DataSource,
  EntityManager,
  EntityTarget,
  ObjectLiteral,
  QueryRunner,
  Repository,
  SelectQueryBuilder,
} from 'typeorm';

import { AccountEntity } from 'src/account/infrastructure/entity/AccountEntity';
import { v4 } from 'uuid';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { DeviceEntity } from 'src/account/infrastructure/entity/DeviceEntity';
import { LotteryResultEntity } from 'src/lottery-result/infrastructure/entity/LotteryResultEntity';

interface WriteConnection {
  readonly startTransaction: (
    level?:
      | 'READ UNCOMMITTED'
      | 'READ COMMITTED'
      | 'REPEATABLE READ'
      | 'SERIALIZABLE',
  ) => Promise<void>;
  readonly commitTransaction: () => Promise<void>;
  readonly rollbackTransaction: () => Promise<void>;
  readonly isTransactionActive: boolean;
  readonly manager: EntityManager;
}

interface ReadConnection {
  readonly getRepository: <T extends ObjectLiteral>(
    target: EntityTarget<T>,
  ) => Repository<T>;
  readonly query: (query: string) => Promise<void>;
  readonly createQueryBuilder: <Entity extends ObjectLiteral>(
    entityClass: EntityTarget<Entity>,
    alias: string,
    queryRunner?: QueryRunner,
  ) => SelectQueryBuilder<Entity>;
}

export let writeConnection = {} as WriteConnection;
export let readConnection = {} as ReadConnection;

@Injectable()
class DatabaseService implements OnModuleInit, OnModuleDestroy {
  constructor(private config: ConfigService) {}
  private readonly dataSource = new DataSource({
    type: 'mysql',
    entities: [AccountEntity, DeviceEntity, LotteryResultEntity],
    charset: 'utf8mb4_unicode_ci',
    logging: this.config.get<boolean>('DATABASE_LOGGING'),
    host: this.config.get<string>('DATABASE_HOST'),
    port: this.config.get<number>('DATABASE_PORT'),
    database: this.config.get<string>('DATABASE_NAME'),
    username: this.config.get<string>('DATABASE_USER'),
    password: this.config.get<string>('DATABASE_PASSWORD'),
    synchronize: this.config.get<boolean>('DATABASE_SYNC'),
  });

  async onModuleInit(): Promise<void> {
    await this.dataSource.initialize();
    if (!this.dataSource.isInitialized)
      throw new Error('DataSource is not initialized');
    writeConnection = this.dataSource.createQueryRunner();
    readConnection = this.dataSource.manager;
  }

  async onModuleDestroy(): Promise<void> {
    await this.dataSource.destroy();
  }
}

export class EntityId extends String {
  constructor() {
    super(v4().split('-').join(''));
  }
}

export const ENTITY_ID_TRANSFORMER = 'EntityIdTransformer';

export interface EntityIdTransformer {
  from: (dbData: Buffer) => string;
  to: (stringId: string) => Buffer;
}

class EntityIdTransformerImplement implements EntityIdTransformer {
  from(dbData: Buffer): string {
    return Buffer.from(dbData.toString('binary'), 'ascii').toString('hex');
  }

  to(entityData: string): Buffer {
    return Buffer.from(entityData, 'hex');
  }
}

@Global()
@Module({
  imports: [ConfigModule],
  providers: [
    DatabaseService,
    {
      provide: ENTITY_ID_TRANSFORMER,
      useClass: EntityIdTransformerImplement,
    },
  ],
  exports: [ENTITY_ID_TRANSFORMER],
})
export class DatabaseModule {}
