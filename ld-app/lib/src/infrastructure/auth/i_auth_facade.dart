import 'package:ld_app/src/domain/account.dart';

class Token {
  String accessToken;
  Token(this.accessToken);
}

abstract interface class IAuthFacade {
  Stream<Account> get status;
  Account? get currentAccount;
  Future<Token> logIn({required String phone, required String password});
  Future<Account?> register({required String phone, required String password});
  Future<void> logOut();
}
