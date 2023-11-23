import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ld_app/src/domain/account.dart';
import 'package:ld_app/src/infrastructure/auth/i_auth_facade.dart';

part 'app_event.dart';
part 'app_state.dart';

@singleton
class AppBloc extends Bloc<AppEvent, AppState> {
  final IAuthFacade authFacade;

  AppBloc(this.authFacade)
      : super(
          authFacade.currentAccount != null
              ? AppState.authenticated(authFacade.currentAccount!)
              : const AppState.unauthenticated(),
        ) {
    on<_AppAccountChanged>(_onAccountChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _accountSubscription = authFacade.status.listen(
      (account) => add(_AppAccountChanged(account)),
    );
  }

  late final StreamSubscription<Account> _accountSubscription;

  void _onAccountChanged(_AppAccountChanged event, Emitter<AppState> emit) {
    emit(
      event.account != null
          ? AppState.authenticated(event.account)
          : const AppState.unauthenticated(),
    );
  }

  void _onLogoutRequested(AppLogoutRequested event, Emitter<AppState> emit) {
    unawaited(authFacade.logOut());
  }

  @override
  Future<void> close() {
    _accountSubscription.cancel();
    return super.close();
  }
}
