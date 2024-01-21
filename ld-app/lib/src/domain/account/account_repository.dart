part of 'account.dart';

abstract interface class AccountRepository {
  TaskEither<AccountException, IAccount> getAccount(String id);
  TaskEither<AccountException, Unit> create(IAccount account);
  TaskEither<AccountException, Unit> update(IAccount account);
  TaskEither<AccountException, Unit> delete(IAccount account);
}
