import { ModuleMetadata, Provider } from '@nestjs/common';
import { Test } from '@nestjs/testing';

import { InjectionToken } from '../../application/InjectionToken';
import { AccountFactory } from '../../../account/domain/AccountFactory';

import { LockAccountHandler } from './LockAccountHandler';
import { LockAccountCommand } from './LockAccountCommand';
import { IAccountRepository } from '../IAccountRepository';

jest.mock('../../../../libs/Transactional', () => ({
  Transactional: () => () => undefined,
}));

describe('LockAccountHandler', () => {
  let handler: LockAccountHandler;
  let repository: IAccountRepository;
  beforeEach(async () => {
    const repoProvider: Provider = {
      provide: InjectionToken.ACCOUNT_REPOSITORY,
      useValue: {},
    };
    const factoryProvider: Provider = {
      provide: AccountFactory,
      useValue: {},
    };
    const providers: Provider[] = [
      LockAccountHandler,
      repoProvider,
      factoryProvider,
    ];
    const moduleMetadata: ModuleMetadata = { providers };
    const testModule = await Test.createTestingModule(moduleMetadata).compile();

    handler = testModule.get(LockAccountHandler);
    repository = testModule.get(InjectionToken.ACCOUNT_REPOSITORY);
  });

  describe('execute', () => {
    it('should execute LockAccountCommand', async () => {
      const account = { lock: jest.fn(), commit: jest.fn() };

      repository.save = jest.fn().mockResolvedValue(undefined);
      repository.findById = jest.fn().mockResolvedValue(account);

      const command = new LockAccountCommand(1);

      await expect(handler.execute(command)).resolves.toEqual(undefined);
      expect(repository.findById).toHaveBeenCalledTimes(1);
      expect(repository.findById).toHaveBeenCalledWith(1);
      expect(account.lock).toHaveBeenCalledTimes(1);
      expect(repository.save).toHaveBeenCalledTimes(1);
      expect(repository.save).toHaveBeenCalledWith(account);
      expect(account.commit).toHaveBeenCalledTimes(1);
    });
  });
});
