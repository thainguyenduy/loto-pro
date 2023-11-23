import 'package:ld_app/src/domain/account.dart';

class Token {
  String accessToken;
  Token(this.accessToken);
}

abstract class IAuthFacade {
  Stream<Account> get status;
  Account? get currentAccount;
  Future<Token> signIn({required String phone, required String password});
  Future<Account?> register({required String phone, required String password});
  Future<void> logOut();
}
