part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppLogoutRequested extends AppEvent {
  const AppLogoutRequested();
}

final class _AppStatusChanged extends AppEvent {
  _AppStatusChanged(this.appStatus, [this.accessToken]);
  AppStatus appStatus;
  AccessToken? accessToken;
}
