import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/task_either.dart';
import 'package:fpdart/src/unit.dart';
import 'package:injectable/injectable.dart';

import 'package:ld_app/src/infrastructure/database/model/model.dart' as model;
import 'package:ld_app/src/domain/account/account.dart';
import 'package:ld_app/src/infrastructure/mapper/account_mapper.dart';

@Singleton(as: AccountRepository)
final class AccountRepositoryImpl implements AccountRepository {
  final AccountMapper accountMapper;
  AccountRepositoryImpl(this.accountMapper);
  @override
  // TODO: implement account
  TaskEither<AccountFailure, Account> getAccount(String id) {
    /* final rte = ReaderTaskEither<Deps, AccountFailure, Account>.Do(($) async {
      final env = await $(ReaderTaskEither.asks(identity));
      final res = env.$1.getById(env.$2);
      final te = TaskEither.fromNullable(res, () => NullableAccountFailure());
    }).run((account, id));
    return TaskEither(() => rte); */
    final accMayNullTE = TaskEither.tryCatch(
        () => model.Account().getById(id, preload: true),
        (_, __) => AccountDataAccessFailure());
    TaskEither<AccountFailure, model.Account> accTE(model.Account? acc) =>
        TaskEither.fromNullable(acc, () => AccountNotFoundFailure());
    IOEither<AccountFailure, Account> modelToDomainIOE(model.Account acc) =>
        IOEither.tryCatch(() => accountMapper.toDomain(acc),
            (_, __) => AccountDomainFailure());
    final res = accMayNullTE
        .flatMap(accTE as TaskEither<AccountDataAccessFailure, dynamic>
            Function(model.Account? r))
        .flatMap(modelToDomainIOE
            as TaskEither<AccountDataAccessFailure, dynamic> Function(
                dynamic r))
        .map((r) => r as Account);
    return res;
  }

  @override
  TaskEither<AccountFailure, Unit> create(Account account) {
    return TaskEither.tryCatch(
        () => model.Account.fromMap(account.toJson()).save(),
        (error, stackTrace) => AccountCreatedFailure()).map((r) => unit);
  }

  @override
  TaskEither<AccountFailure, Unit> delete(Account account) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  TaskEither<AccountFailure, Unit> update(Account account) {
    return TaskEither.tryCatch(
        () => model.Account.fromMap(account.toJson()).save(),
        (error, stackTrace) => AccountUpdatedFailure()).map((r) => unit);
  }
}
