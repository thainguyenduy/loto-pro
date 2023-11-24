// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../application/app/bloc/app_bloc.dart' as _i9;
import '../application/login/bloc/login_bloc.dart' as _i8;
import '../screens/router/router.dart' as _i3;
import 'app.module.dart' as _i10;
import 'auth/i_auth_facade.dart' as _i6;
import 'auth/impl/auth_facade.dart' as _i7;
import 'notification.service.dart' as _i4;

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
    gh.factory<_i3.AppRouter>(() => appModule.appRouter);
    await gh.factoryAsync<_i4.NotificationService>(
      () => appModule.notificationService,
      preResolve: true,
    );
    gh.factory<String>(
      () => appModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.lazySingleton<_i5.Dio>(
        () => appModule.dio(gh<String>(instanceName: 'BaseUrl')));
    gh.singleton<_i6.IAuthFacade>(_i7.AuthFacade(gh<_i5.Dio>()));
    gh.factory<_i8.LoginBloc>(
        () => _i8.LoginBloc(authFacade: gh<_i6.IAuthFacade>()));
    gh.singleton<_i9.AppBloc>(_i9.AppBloc(gh<_i6.IAuthFacade>()));
    return this;
  }
}

class _$AppModule extends _i10.AppModule {}
