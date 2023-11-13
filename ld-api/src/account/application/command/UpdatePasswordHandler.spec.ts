import { ModuleMetadata, NotFoundException, Provider } from '@nestjs/common';
import { Test } from '@nestjs/testing';

import { UpdatePasswordCommand } from './UpdatePasswordCommand';
import { UpdatePasswordHandler } from './UpdatePasswordHandler';
import { InjectionToken } from '../../application/InjectionToken';
import { AccountRepository } from '../../infrastructure/repository/AccountRepository';

jest.mock('../../../../libs/Transactional', () => ({
  Transactional: () => () => undefined,
}));

describe('UpdatePasswordHandler', () => {
  let handler: UpdatePasswordHandler;
  let repository: AccountRepository;

  beforeEach(async () => {
    const repoProvider: Provider = {
      provide: InjectionToken.ACCOUNT_REPOSITORY,
      useValue: {},
    };

    const providers: Provider[] = [UpdatePasswordHandler, repoProvider];
    const moduleMetadata: ModuleMetadata = { providers };
    const testModule = await Test.createTestingModule(moduleMetadata).compile();

    handler = testModule.get(UpdatePasswordHandler);
    repository = testModule.get(InjectionToken.ACCOUNT_REPOSITORY);
  });

  describe('execute', () => {
    it('should throw NotFoundException when account not found', async () => {
      repository.findById = jest.fn().mockResolvedValue(null);

      const command = new UpdatePasswordCommand(1, 'password');

      await expect(handler.execute(command)).rejects.toThrowError(
        NotFoundException,
      );
      expect(repository.findById).toBeCalledTimes(1);
      expect(repository.findById).toBeCalledWith(command.accountId);
    });

    it('should execute UpdatePasswordCommand', async () => {
      const account = { updatePassword: jest.fn(), commit: jest.fn() };

      repository.findById = jest.fn().mockResolvedValue(account);
      repository.save = jest.fn().mockResolvedValue(undefined);

      const command = new UpdatePasswordCommand(1, 'password');

      await expect(handler.execute(command)).resolves.toEqual(undefined);
      expect(repository.findById).toBeCalledTimes(1);
      expect(repository.findById).toBeCalledWith(command.accountId);
      expect(account.updatePassword).toBeCalledTimes(1);
      expect(account.updatePassword).toBeCalledWith(command.password);
      expect(repository.save).toBeCalledTimes(1);
      expect(repository.save).toBeCalledWith(account);
      expect(account.commit).toBeCalledTimes(1);
    });
  });
});
