// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:android_id/android_id.dart' as _i3;
import 'package:device_info_plus/device_info_plus.dart' as _i9;
import 'package:dio/dio.dart' as _i18;
import 'package:event_bus/event_bus.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:ld_app/src/application/app/app_bloc.dart' as _i23;
import 'package:ld_app/src/application/login/login_bloc.dart' as _i21;
import 'package:ld_app/src/application/telegram_auth/telegram_authentication_bloc.dart'
    as _i22;
import 'package:ld_app/src/domain/account/account.dart' as _i15;
import 'package:ld_app/src/domain/account/i_auth_facade.dart' as _i19;
import 'package:ld_app/src/domain/contact/contact.dart' as _i7;
import 'package:ld_app/src/infrastructure/app.module.dart' as _i24;
import 'package:ld_app/src/infrastructure/auth/auth_facade.dart' as _i20;
import 'package:ld_app/src/infrastructure/database/repository/acount_repository_impl.dart'
    as _i16;
import 'package:ld_app/src/infrastructure/database/repository/contact_repository_impl.dart'
    as _i8;
import 'package:ld_app/src/infrastructure/device_info.dart' as _i17;
import 'package:ld_app/src/infrastructure/mapper/account_mapper.dart' as _i14;
import 'package:ld_app/src/infrastructure/mapper/contact_mapper.dart' as _i6;
import 'package:ld_app/src/infrastructure/notification.service.dart' as _i11;
import 'package:ld_app/src/infrastructure/service/telegram_service.dart'
    as _i13;
import 'package:ld_app/src/presentation/router/router.dart' as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i12;
import 'package:tdlib/td_client.dart' as _i5;

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
    gh.lazySingleton<_i4.AppRouter>(() => appModule.appRouter);
    gh.lazySingleton<_i5.Client>(() => appModule.client);
    gh.lazySingleton<_i6.ContactMapper>(() => _i6.ContactMapper());
    gh.lazySingleton<_i7.ContactRepository>(
        () => _i8.ContactRepositoryImpl(gh<_i6.ContactMapper>()));
    gh.lazySingleton<_i9.DeviceInfoPlugin>(() => appModule.deviceInfo);
    gh.lazySingleton<_i10.EventBus>(() => appModule.eventBus);
    await gh.factoryAsync<_i11.NotificationService>(
      () => appModule.notificationService,
      preResolve: true,
    );
    await gh.factoryAsync<_i12.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<String>(
      () => appModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.lazySingleton<_i13.TelegramService>(
        () => appModule.getService(gh<_i5.Client>()));
    gh.lazySingleton<_i14.AccountMapper>(
        () => _i14.AccountMapper(gh<_i6.ContactMapper>()));
    gh.lazySingleton<_i15.AccountRepository>(
        () => _i16.AccountRepositoryImpl(gh<_i14.AccountMapper>()));
    gh.lazySingleton<_i17.DeviceInfo>(() => _i17.DeviceInfo(
          gh<_i9.DeviceInfoPlugin>(),
          gh<_i3.AndroidId>(),
        ));
    gh.lazySingleton<_i18.Dio>(
        () => appModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.lazySingleton<_i19.IAuthFacade>(() => _i20.AuthFacade(
          gh<_i18.Dio>(),
          gh<_i17.DeviceInfo>(),
        ));
    gh.factory<_i21.LoginBloc>(
        () => _i21.LoginBloc(authFacade: gh<_i19.IAuthFacade>()));
    gh.lazySingleton<_i22.TelegramAuthenticationBloc>(
        () => _i22.TelegramAuthenticationBloc(gh<_i13.TelegramService>()));
    gh.lazySingleton<_i23.AppBloc>(() => _i23.AppBloc(gh<_i19.IAuthFacade>()));
    return this;
  }
}

class _$AppModule extends _i24.AppModule {
  @override
  _i3.AndroidId get androidId => const _i3.AndroidId();

  @override
  _i9.DeviceInfoPlugin get deviceInfo => _i9.DeviceInfoPlugin();
}
