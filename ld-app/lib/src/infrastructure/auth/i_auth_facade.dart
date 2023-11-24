import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ld_app/src/domain/account.dart';

class Token {
  String accessToken;
  Token(this.accessToken);
}

abstract interface class IAuthFacade {
  Stream<Account> get status;
  Account? get currentAccount;
  TaskEither<LoginFailure, Token> logIn(
      {required String phone, required String password});
  Future<Account?> register({required String phone, required String password});
  Future<void> logOut();
}

sealed class AuthFacadeFailure {}

class LoginFailure extends AuthFacadeFailure {
  String message;
  LoginFailure(this.message);
}

class RegistrationFailure extends AuthFacadeFailure {
  String message;
  RegistrationFailure(this.message);
}
