import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/domain/account.dart';
import 'package:ld_app/src/infrastructure/exception/network_error_handler.dart';
import 'package:ld_app/src/screens/app/bloc/app_bloc.dart';

abstract interface class IAuthFacade {
  Stream<AppStatus> get status;
  TaskEither<NetworkErrorHandler, Unit> logIn(
      {required String phone, required String password});
  Future<Account?> register({required String phone, required String password});
  Future<void> logOut();
}
