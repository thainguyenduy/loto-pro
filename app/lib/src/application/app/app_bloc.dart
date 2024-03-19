import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:ld_app/src/domain/accessToken.dart';
import 'package:ld_app/src/domain/account/i_auth_facade.dart';

part 'app_event.dart';
part 'app_state.dart';

@lazySingleton
class AppBloc extends Bloc<AppEvent, AppState> {
  final IAuthFacade authFacade;

  AppBloc(this.authFacade)
      : super(
          const AppState.unauthenticated(),
        ) {
    on<_AppStatusChanged>(_onAppStatusChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _appStatusSubscription = authFacade.status.listen(
      (status) => add(_AppStatusChanged(status)),
    );
  }

  late final StreamSubscription<AppStatus> _appStatusSubscription;

  void _onAppStatusChanged(_AppStatusChanged event, Emitter<AppState> emit) {
    switch (event.appStatus) {
      case AppStatus.unauthenticated:
        return emit(const AppState.unauthenticated());
      case AppStatus.authenticated:
        final accessToken = AccessToken.fromCache();
        return emit(AppState.authenticated(accessToken));
    }
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(authFacade.logOut());
  }

  @override
  Future<void> close() {
    _appStatusSubscription.cancel();
    return super.close();
  }
}
