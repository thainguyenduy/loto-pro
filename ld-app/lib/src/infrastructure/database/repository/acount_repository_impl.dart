import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/task_either.dart';
import 'package:fpdart/src/unit.dart';
import 'package:injectable/injectable.dart';

import 'package:ld_app/src/infrastructure/database/model/model.dart' as model;
import 'package:ld_app/src/domain/account/account.dart';
import 'package:ld_app/src/infrastructure/mapper/account_mapper.dart';

@injectable
final class AccountRepositoryImpl implements AccountRepository {
  late model.Account account;
  final AccountMapper accountMapper;
  AccountRepositoryImpl(this.account, this.accountMapper);

  @PostConstruct()
  void init() {
    account = model.Account();
  }

  @override
  // TODO: implement account
  TaskEither<AccountException, IAccount> getAccount(String id) {
    /* final rte = ReaderTaskEither<Deps, AccountException, IAccount>.Do(($) async {
      final env = await $(ReaderTaskEither.asks(identity));
      final res = env.$1.getById(env.$2);
      final te = TaskEither.fromNullable(res, () => NullableAccountException());
    }).run((account, id));
    return TaskEither(() => rte); */
    final accMayNullTE = TaskEither.tryCatch(
        () => account.getById(id, preload: true),
        (_, __) => AccountDataAccessException());
    TaskEither<AccountException, model.Account> accTE(model.Account? acc) =>
        TaskEither.fromNullable(acc, () => AccountNotFoundException());
    IOEither<AccountException, IAccount> modelToDomainIOE(model.Account acc) =>
        IOEither.tryCatch(() => accountMapper.toDomain(acc),
            (_, __) => AccountDomainException());
    final res = accMayNullTE
        .flatMap(accTE as TaskEither<AccountDataAccessException, dynamic>
            Function(model.Account? r))
        .flatMap(modelToDomainIOE
            as TaskEither<AccountDataAccessException, dynamic> Function(
                dynamic r))
        .map((r) => r as IAccount);
    return res;
  }

  @override
  TaskEither<AccountException, Unit> create(IAccount account) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  TaskEither<AccountException, Unit> delete(IAccount account) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  TaskEither<AccountException, Unit> update(IAccount account) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
