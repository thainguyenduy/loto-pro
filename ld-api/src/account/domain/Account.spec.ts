import { UnprocessableEntityException } from '@nestjs/common';

import { PasswordUpdatedEvent } from 'src/account/domain/event/PasswordUpdatedEvent';
import { Account, AccountProps } from './Account';
import { Password, Phone } from 'libs/domain';
import { AccountDeviceChangedEvent } from './event/AccountDeviceChangedEvent';
import { AccountLockedEvent } from './event/AccountLockedEvent';

describe('Account', () => {
  let phone: Phone;
  let data: AccountProps;
  let account: Account;
  beforeEach(() => {
    phone = Phone.create({ value: '0912321938' });
    data = {
      id: 'id',
      phone,
      password: Password.create({ value: '123456', hashed: true }),
      deviceId: 'abcxyz',
    } as AccountProps;
    account = new Account(data);
  });
  describe('active', () => {
    it('should apply DeviceChangedEvent', () => {
      account.active(new Date());

      const appliedEvent = account.getUncommittedEvents();

      expect(appliedEvent).toEqual([
        new AccountDeviceChangedEvent('id', 'abcxyz', phone),
      ]);
    });
  });

  describe('updatePassword', () => {
    it('should update password', () => {
      account.updatePassword('password');
      expect(account.getUncommittedEvents().length).toEqual(1);
      expect(account.getUncommittedEvents()).toEqual([
        new PasswordUpdatedEvent('id', phone),
      ]);
      expect(account.updatePassword('password')).toEqual(undefined);
    });
  });

  describe('lock', () => {
    it('should throw UnprocessableEntityException when account has already been locked', () => {
      expect(() => account.lock()).toThrow(UnprocessableEntityException);
    });

    it('should lock account', () => {
      account.lock();

      expect(account.getUncommittedEvents()).toEqual([
        new AccountLockedEvent('id', phone),
      ]);
    });
  });

  describe('changeDevice', () => {});
});
