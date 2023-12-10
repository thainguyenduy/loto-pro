// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:android_id/android_id.dart' as _i3;
import 'package:device_info_plus/device_info_plus.dart' as _i5;
import 'package:dio/dio.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../application/app/app_bloc.dart' as _i14;
import '../application/login/login_bloc.dart' as _i13;
import '../application/telegram_authentication/telegram_authentication_bloc.dart'
    as _i8;
import '../screens/router/router.dart' as _i4;
import 'app.module.dart' as _i15;
import 'auth/i_auth_facade.dart' as _i11;
import 'auth/impl/auth_facade.dart' as _i12;
import 'device_info.dart' as _i9;
import 'notification.service.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.lazySingleton<_i3.AndroidId>(() => appModule.androidId);
    gh.singleton<_i4.AppRouter>(appModule.appRouter);
    gh.lazySingleton<_i5.DeviceInfoPlugin>(() => appModule.deviceInfo);
    await gh.factoryAsync<_i6.NotificationService>(
      () => appModule.notificationService,
      preResolve: true,
    );
    await gh.factoryAsync<_i7.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<String>(
      () => appModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.lazySingleton<_i8.TelegramAuthenticationBloc>(
        () => _i8.TelegramAuthenticationBloc());
    gh.lazySingleton<_i9.DeviceInfo>(() => _i9.DeviceInfo(
          gh<_i5.DeviceInfoPlugin>(),
          gh<_i3.AndroidId>(),
        ));
    gh.lazySingleton<_i10.Dio>(
        () => appModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.singleton<_i11.IAuthFacade>(_i12.AuthFacade(
      gh<_i10.Dio>(),
      gh<_i9.DeviceInfo>(),
    ));
    gh.factory<_i13.LoginBloc>(
        () => _i13.LoginBloc(authFacade: gh<_i11.IAuthFacade>()));
    gh.singleton<_i14.AppBloc>(_i14.AppBloc(gh<_i11.IAuthFacade>()));
    return this;
  }
}

class _$AppModule extends _i15.AppModule {
  @override
  _i3.AndroidId get androidId => const _i3.AndroidId();

  @override
  _i5.DeviceInfoPlugin get deviceInfo => _i5.DeviceInfoPlugin();
}
