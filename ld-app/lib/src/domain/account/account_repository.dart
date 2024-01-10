import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/domain/account/account.dart';
import 'package:ld_app/src/domain/account/account_failure.dart';

abstract interface class AccountRepository {
  TaskEither<AccountFailure, IAccount> get account;
  TaskEither<AccountFailure, Unit> create(IAccount account);
  TaskEither<AccountFailure, Unit> update(IAccount account);
  TaskEither<AccountFailure, Unit> delete(IAccount account);
}
