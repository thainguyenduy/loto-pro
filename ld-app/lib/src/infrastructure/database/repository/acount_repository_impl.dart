import 'package:fpdart/src/task_either.dart';
import 'package:fpdart/src/unit.dart';

import 'package:ld_app/src/infrastructure/database/model/model.dart' as model;
import 'package:ld_app/src/domain/account/account.dart';
import 'package:ld_app/src/domain/account/account_failure.dart';
import 'package:ld_app/src/domain/account/account_repository.dart';

final class AccountRepositoryImpl implements AccountRepository {
  @override
  // TODO: implement account
  TaskEither<AccountFailure, IAccount> get account {
    return TaskEither.tryCatch(() {
      model.Account().getById();
    } , (error, stackTrace) => null)
  };

  @override
  TaskEither<AccountFailure, Unit> create(IAccount account) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  TaskEither<AccountFailure, Unit> delete(IAccount account) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  TaskEither<AccountFailure, Unit> update(IAccount account) {
    // TODO: implement update
    throw UnimplementedError();
  }
}