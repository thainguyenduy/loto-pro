// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:android_id/android_id.dart' as _i3;
import 'package:device_info_plus/device_info_plus.dart' as _i5;
import 'package:dio/dio.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../application/app/bloc/app_bloc.dart' as _i13;
import '../application/login/bloc/login_bloc.dart' as _i12;
import '../screens/router/router.dart' as _i4;
import 'app.module.dart' as _i14;
import 'auth/i_auth_facade.dart' as _i10;
import 'auth/impl/auth_facade.dart' as _i11;
import 'device_info.dart' as _i8;
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
    gh.factory<_i4.AppRouter>(() => appModule.appRouter);
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
    gh.lazySingleton<_i8.DeviceInfo>(() => _i8.DeviceInfo(
          gh<_i5.DeviceInfoPlugin>(),
          gh<_i3.AndroidId>(),
        ));
    gh.lazySingleton<_i9.Dio>(
        () => appModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.singleton<_i10.IAuthFacade>(_i11.AuthFacade(
      gh<_i9.Dio>(),
      gh<_i8.DeviceInfo>(),
    ));
    gh.factory<_i12.LoginBloc>(
        () => _i12.LoginBloc(authFacade: gh<_i10.IAuthFacade>()));
    gh.singleton<_i13.AppBloc>(_i13.AppBloc(gh<_i10.IAuthFacade>()));
    return this;
  }
}

class _$AppModule extends _i14.AppModule {
  @override
  _i3.AndroidId get androidId => const _i3.AndroidId();

  @override
  _i5.DeviceInfoPlugin get deviceInfo => _i5.DeviceInfoPlugin();
}
