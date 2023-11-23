// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../application/app/bloc/app_bloc.dart' as _i8;
import '../application/login/bloc/login_bloc.dart' as _i6;
import '../screens/router/router.dart' as _i3;
import 'app.module.dart' as _i10;
import 'auth/i_auth_facade.dart' as _i4;
import 'auth/impl/auth_facade.dart' as _i5;
import 'notification.service.dart' as _i7;

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
    gh.singleton<_i4.IAuthFacade>(_i5.AuthFacade());
    gh.factory<_i6.LoginBloc>(
        () => _i6.LoginBloc(authFacade: gh<_i5.AuthFacade>()));
    await gh.factoryAsync<_i7.NotificationService>(
      () => appModule.notificationService,
      preResolve: true,
    );
    gh.factory<String>(
      () => appModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.singleton<_i8.AppBloc>(_i8.AppBloc(gh<_i4.IAuthFacade>()));
    gh.lazySingleton<_i9.Dio>(
        () => appModule.dio(gh<String>(instanceName: 'BaseUrl')));
    return this;
  }
}

class _$AppModule extends _i10.AppModule {}
