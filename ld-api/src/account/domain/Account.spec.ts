import { UnprocessableEntityException } from '@nestjs/common';

import { Account, AccountProps } from './Account';
import { Password, Phone } from '../../../libs/domain';
import { AccountLockedEvent } from './event/AccountLockedEvent';
import { PasswordUpdatedEvent } from './event/PasswordUpdatedEvent';
import { AccountActivationExtendedEvent } from './event/AccountActivationExtendedEvent';

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
      const date = new Date();
      account.active(date);

      const appliedEvent = account.getUncommittedEvents();

      expect(appliedEvent).toEqual([
        new AccountActivationExtendedEvent('id', 'abcxyz', phone, date),
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
      const phone = Phone.create({ value: '0912321938' });
      const data = {
        id: 'id',
        phone,
        password: Password.create({ value: '123456', hashed: true }),
        deviceId: 'abcxyz',
        lockedAt: new Date(),
      } as AccountProps;
      account = new Account(data);
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
