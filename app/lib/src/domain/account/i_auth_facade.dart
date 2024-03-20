import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/presentation/app/bloc/app.dart';
import 'package:ld_app/src/domain/account/account.dart';
import 'package:ld_app/src/infrastructure/exception/network_exception_handler.dart';

abstract interface class IAuthFacade {
  Stream<AppStatus> get status;
  TaskEither<NetworkExceptionHandler, Unit> logIn(
      {required String phone, required String password});
  Future<Account?> register({required String phone, required String password});
  Future<void> logOut();
}
