// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:android_id/android_id.dart' as _i3;
import 'package:device_info_plus/device_info_plus.dart' as _i7;
import 'package:dio/dio.dart' as _i15;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;
import 'package:tdlib/td_client.dart' as _i5;

import '../application/app/app_bloc.dart' as _i20;
import '../application/login/login_bloc.dart' as _i18;
import '../application/telegram_auth/telegram_authentication_bloc.dart' as _i19;
import '../presentation/router/router.dart' as _i4;
import 'app.module.dart' as _i21;
import 'auth/i_auth_facade.dart' as _i16;
import 'auth/impl/auth_facade.dart' as _i17;
import 'database/model/model.dart' as _i13;
import 'database/repository/acount_repository_impl.dart' as _i12;
import 'device_info.dart' as _i14;
import 'mapper/account_mapper.dart' as _i11;
import 'mapper/contact_mapper.dart' as _i6;
import 'notification.service.dart' as _i8;
import 'service/telegram_service.dart' as _i10;

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
    gh.singleton<_i6.ContactMapper>(_i6.ContactMapper());
    gh.lazySingleton<_i7.DeviceInfoPlugin>(() => appModule.deviceInfo);
    await gh.factoryAsync<_i8.NotificationService>(
      () => appModule.notificationService,
      preResolve: true,
    );
    await gh.factoryAsync<_i9.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<String>(
      () => appModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.lazySingleton<_i10.TelegramService>(
        () => appModule.getService(gh<_i5.Client>()));
    gh.singleton<_i11.AccountMapper>(
        _i11.AccountMapper(gh<_i6.ContactMapper>()));
    gh.factory<_i12.AccountRepositoryImpl>(() => _i12.AccountRepositoryImpl(
          gh<_i13.Account>(),
          gh<_i11.AccountMapper>(),
        )..init());
    gh.lazySingleton<_i14.DeviceInfo>(() => _i14.DeviceInfo(
          gh<_i7.DeviceInfoPlugin>(),
          gh<_i3.AndroidId>(),
        ));
    gh.lazySingleton<_i15.Dio>(
        () => appModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.singleton<_i16.IAuthFacade>(_i17.AuthFacade(
      gh<_i15.Dio>(),
      gh<_i14.DeviceInfo>(),
    ));
    gh.factory<_i18.LoginBloc>(
        () => _i18.LoginBloc(authFacade: gh<_i16.IAuthFacade>()));
    gh.singleton<_i19.TelegramAuthenticationBloc>(
        _i19.TelegramAuthenticationBloc(gh<_i10.TelegramService>()));
    gh.singleton<_i20.AppBloc>(_i20.AppBloc(gh<_i16.IAuthFacade>()));
    return this;
  }
}

class _$AppModule extends _i21.AppModule {
  @override
  _i3.AndroidId get androidId => const _i3.AndroidId();

  @override
  _i7.DeviceInfoPlugin get deviceInfo => _i7.DeviceInfoPlugin();
}
