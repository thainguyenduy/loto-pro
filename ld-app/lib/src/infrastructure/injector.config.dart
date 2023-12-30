// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:android_id/android_id.dart' as _i3;
import 'package:device_info_plus/device_info_plus.dart' as _i6;
import 'package:dio/dio.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;
import 'package:tdlib/td_client.dart' as _i5;

import '../screens/app/bloc/app_bloc.dart' as _i16;
import '../screens/login/bloc/login_bloc.dart' as _i14;
import '../screens/router/router.dart' as _i4;
import '../screens/telegram/bloc/telegram_authentication_bloc.dart' as _i15;
import 'app.module.dart' as _i17;
import 'auth/i_auth_facade.dart' as _i12;
import 'auth/impl/auth_facade.dart' as _i13;
import 'device_info.dart' as _i10;
import 'notification.service.dart' as _i7;
import 'service/telegram_service.dart' as _i9;

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
    gh.lazySingleton<_i5.Client>(() => appModule.client);
    gh.lazySingleton<_i6.DeviceInfoPlugin>(() => appModule.deviceInfo);
    await gh.factoryAsync<_i7.NotificationService>(
      () => appModule.notificationService,
      preResolve: true,
    );
    await gh.factoryAsync<_i8.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<String>(
      () => appModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.lazySingleton<_i9.TelegramService>(
        () => appModule.getService(gh<_i5.Client>()));
    gh.lazySingleton<_i10.DeviceInfo>(() => _i10.DeviceInfo(
          gh<_i6.DeviceInfoPlugin>(),
          gh<_i3.AndroidId>(),
        ));
    gh.lazySingleton<_i11.Dio>(
        () => appModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.singleton<_i12.IAuthFacade>(_i13.AuthFacade(
      gh<_i11.Dio>(),
      gh<_i10.DeviceInfo>(),
    ));
    gh.factory<_i14.LoginBloc>(
        () => _i14.LoginBloc(authFacade: gh<_i12.IAuthFacade>()));
    gh.singleton<_i15.TelegramAuthenticationBloc>(
        _i15.TelegramAuthenticationBloc(gh<_i9.TelegramService>()));
    gh.singleton<_i16.AppBloc>(_i16.AppBloc(gh<_i12.IAuthFacade>()));
    return this;
  }
}

class _$AppModule extends _i17.AppModule {
  @override
  _i3.AndroidId get androidId => const _i3.AndroidId();

  @override
  _i6.DeviceInfoPlugin get deviceInfo => _i6.DeviceInfoPlugin();
}
