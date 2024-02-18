part of 'account.dart';

abstract interface class AccountRepository {
  TaskEither<AccountFailure, Account> getAccount(String id);
  TaskEither<AccountFailure, Unit> create(Account account);
  TaskEither<AccountFailure, Unit> update(Account account);
  TaskEither<AccountFailure, Unit> delete(Account account);
}
