import { ModuleMetadata, Provider } from '@nestjs/common';
import { Test } from '@nestjs/testing';

import { OpenAccountCommand } from './OpenAccountCommand';
import { OpenAccountHandler } from './OpenAccountHandler';
import { InjectionToken } from '../InjectionToken';
import { AccountFactory } from '../../domain/AccountFactory';
import { IAccountRepository } from '../IAccountRepository';
import { EventBus } from '@nestjs/cqrs';
import { AccountDeviceChangedEvent } from '../../domain/event/AccountDeviceChangedEvent';

jest.mock('../../../../libs/Transactional', () => ({
  Transactional: () => () => undefined,
}));

describe('OpenAccountHandler', () => {
  let handler: OpenAccountHandler;
  let repository: IAccountRepository;
  let factory: AccountFactory;
  let eventBus: EventBus;
  beforeEach(async () => {
    const repoProvider: Provider = {
      provide: InjectionToken.ACCOUNT_REPOSITORY,
      useValue: {},
    };
    const factoryProvider: Provider = {
      provide: AccountFactory,
      useValue: {},
    };
    const eventBusProvider: Provider = {
      provide: EventBus,
      useValue: {},
    };
    const providers: Provider[] = [
      OpenAccountHandler,
      repoProvider,
      factoryProvider,
      eventBusProvider,
    ];
    const moduleMetadata: ModuleMetadata = { providers };
    const testModule = await Test.createTestingModule(moduleMetadata).compile();

    handler = testModule.get(OpenAccountHandler);
    repository = testModule.get(InjectionToken.ACCOUNT_REPOSITORY);
    factory = testModule.get(AccountFactory);
    eventBus = testModule.get(EventBus);
  });

  describe('execute', () => {
    it('should execute OpenAccountCommand', async () => {
      const account = { open: jest.fn(), commit: jest.fn() };

      factory.create = jest.fn().mockReturnValue(account);
      repository.save = jest.fn().mockResolvedValue([account]);
      eventBus.publish = jest.fn().mockReturnValue(undefined);

      const command = new OpenAccountCommand(
        '0912345678',
        'password',
        'deviceid',
      );

      await expect(handler.execute(command)).resolves.toEqual(undefined);
      expect(eventBus.publish).toHaveBeenCalledTimes(1);
      expect(eventBus.publish).toHaveBeenCalledWith(
        expect.any(AccountDeviceChangedEvent),
      );
      expect(account.open).toBeCalledTimes(1);
      expect(repository.save).toBeCalledTimes(1);
      expect(repository.save).toBeCalledWith(account);
      expect(account.commit).toBeCalledTimes(1);
    });
  });
});
