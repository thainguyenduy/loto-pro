part of 'account.dart';

abstract interface class AccountRepository {
  TaskEither<AccountException, Account> getAccount(String id);
  TaskEither<AccountException, Unit> create(Account account);
  TaskEither<AccountException, Unit> update(Account account);
  TaskEither<AccountException, Unit> delete(Account account);
}
