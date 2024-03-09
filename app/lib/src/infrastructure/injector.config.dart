// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:android_id/android_id.dart' as _i3;
import 'package:device_info_plus/device_info_plus.dart' as _i11;
import 'package:dio/dio.dart' as _i20;
import 'package:event_bus/event_bus.dart' as _i12;
import 'package:fpdart/fpdart.dart' as _i7;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i14;
import 'package:tdlib/td_client.dart' as _i5;

import '../application/app/app_bloc.dart' as _i25;
import '../application/contact/bloc/contact_form_bloc.dart' as _i6;
import '../application/login/login_bloc.dart' as _i23;
import '../application/telegram_auth/telegram_authentication_bloc.dart' as _i24;
import '../domain/account/account.dart' as _i17;
import '../domain/account/i_auth_facade.dart' as _i21;
import '../domain/contact/contact.dart' as _i8;
import '../presentation/router/router.dart' as _i4;
import 'app.module.dart' as _i26;
import 'auth/auth_facade.dart' as _i22;
import 'database/repository/acount_repository_impl.dart' as _i18;
import 'database/repository/contact_repository_impl.dart' as _i10;
import 'device_info.dart' as _i19;
import 'mapper/account_mapper.dart' as _i16;
import 'mapper/contact_mapper.dart' as _i9;
import 'notification.service.dart' as _i13;
import 'service/telegram_service.dart' as _i15;

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
    gh.singleton<_i4.AppRouter>(() => appModule.appRouter);
    gh.lazySingleton<_i5.Client>(() => appModule.client);
    gh.factory<_i6.ContactFormBloc>(
        () => _i6.ContactFormBloc(gh<_i7.Either<String, _i8.Contact>>()));
    gh.singleton<_i9.ContactMapper>(() => _i9.ContactMapper());
    gh.singleton<_i8.ContactRepository>(
        () => _i10.ContactRepositoryImpl(gh<_i9.ContactMapper>()));
    gh.lazySingleton<_i11.DeviceInfoPlugin>(() => appModule.deviceInfo);
    gh.lazySingleton<_i12.EventBus>(() => appModule.eventBus);
    await gh.factoryAsync<_i13.NotificationService>(
      () => appModule.notificationService,
      preResolve: true,
    );
    await gh.factoryAsync<_i14.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<String>(
      () => appModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.lazySingleton<_i15.TelegramService>(
        () => appModule.getService(gh<_i5.Client>()));
    gh.singleton<_i16.AccountMapper>(
        () => _i16.AccountMapper(gh<_i9.ContactMapper>()));
    gh.singleton<_i17.AccountRepository>(
        () => _i18.AccountRepositoryImpl(gh<_i16.AccountMapper>()));
    gh.lazySingleton<_i19.DeviceInfo>(() => _i19.DeviceInfo(
          gh<_i11.DeviceInfoPlugin>(),
          gh<_i3.AndroidId>(),
        ));
    gh.lazySingleton<_i20.Dio>(
        () => appModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.singleton<_i21.IAuthFacade>(() => _i22.AuthFacade(
          gh<_i20.Dio>(),
          gh<_i19.DeviceInfo>(),
        ));
    gh.factory<_i23.LoginBloc>(
        () => _i23.LoginBloc(authFacade: gh<_i21.IAuthFacade>()));
    gh.singleton<_i24.TelegramAuthenticationBloc>(
        () => _i24.TelegramAuthenticationBloc(gh<_i15.TelegramService>()));
    gh.singleton<_i25.AppBloc>(() => _i25.AppBloc(gh<_i21.IAuthFacade>()));
    return this;
  }
}

class _$AppModule extends _i26.AppModule {
  @override
  _i3.AndroidId get androidId => const _i3.AndroidId();

  @override
  _i11.DeviceInfoPlugin get deviceInfo => _i11.DeviceInfoPlugin();
}
