import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:ld_app/src/domain/accessToken.dart';
import 'package:ld_app/src/domain/account.dart';
import 'package:ld_app/src/infrastructure/auth/i_auth_facade.dart';
import 'package:ld_app/src/infrastructure/device_info.dart';
import 'package:ld_app/src/infrastructure/exception/network_error_handler.dart';
import 'package:ld_app/src/screens/app/bloc/app_bloc.dart';

@Singleton(as: IAuthFacade)
class AuthFacade implements IAuthFacade {
  Dio dio;
  DeviceInfo deviceInfo;
  AuthFacade(this.dio, this.deviceInfo);
  final _controller = StreamController<AppStatus>();
  @override
  Stream<AppStatus> get status async* {
    final accessToken = AccessToken.fromCache();
    if (accessToken.isValid) {
      yield AppStatus.authenticated;
    } else {
      yield AppStatus.unauthenticated;
    }
    yield* _controller.stream;
  }

  /// Throws a [LogOutFailure] if an exception occurs.
  @override
  Future<void> logOut() async {
    final accessToken = AccessToken.fromCache();
    /* await dio.get("/signout/${(accessToken.payload as Map)['accountId']}",
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        })); */
    await accessToken.clear();
    _controller.add(AppStatus.unauthenticated);
  }

  @override
  Future<Account> register({required String phone, required String password}) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  TaskEither<NetworkErrorHandler, Unit> logIn({
    required String phone,
    required String password,
  }) {
    TaskEither<Object, String> getDeviceId =
        TaskEither.tryCatch(() => deviceInfo.deviceId, (_, __) => _);
    return getDeviceId
        .flatMap((deviceId) => TaskEither.tryCatch(
            () => dio.post('/login', data: {
                  'phone': phone,
                  'password': password,
                  'deviceId': deviceId
                }),
            (e, _) => e))
        .flatMap((result) => TaskEither.fromTask(Task.Do(($) async {
              final accessToken =
                  AccessToken(result.data['accessToken'] as String);
              accessToken.save();
              _controller.add(AppStatus.authenticated);
            })))
        .map((_) {
      return unit;
    }).mapLeft((e) => NetworkErrorHandler<DioException>(e as DioException));
  }

  void dispose() => _controller.close();
}
