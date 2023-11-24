import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:ld_app/src/domain/account.dart';
import 'package:ld_app/src/infrastructure/auth/i_auth_facade.dart';

@Singleton(as: IAuthFacade)
class AuthFacade implements IAuthFacade {
  Dio dio;
  AuthFacade(this.dio);
  final _controller = StreamController<Account>();
  @override
  Stream<Account> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield* _controller.stream;
  }

  /// Throws a [LogOutFailure] if an exception occurs.
  @override
  Future<void> logOut() async {
    throw UnimplementedError();
  }

  @override
  Future<Account> register({required String phone, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  TaskEither<LoginFailure, Token> logIn({
    required String phone,
    required String password,
  }) {
    return TaskEither.tryCatch(
            () => dio.post('/login', data: {
                  'phone': phone,
                  'password': password,
                  'deviceId': 'oifjwef'
                }),
            (_, __) => _)
        .mapLeft((l) => LoginFailure(l.response.data['message'][0][0]))
        .map((r) => Token(r.data));
    /* try {
      final accessToken = await dio.post('/login',
          data: {'phone': phone, 'password': password, 'deviceId': 'oifjwef'});
      // TODO: implement signIn
      return Token(accessToken.data.toString());
    } on DioException catch (e) {
      throw UnimplementedError();
    } */
  }

  @override
  // TODO: implement currentAccount
  Account? get currentAccount => null;
}

String logFailure(AuthFacadeFailure authFailure) {
  switch (authFailure) {
    case LoginFailure _:
      return authFailure.message;
    case RegistrationFailure _:
      return authFailure.message;
  }
}
