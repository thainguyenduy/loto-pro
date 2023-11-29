part of 'app_bloc.dart';

enum AppStatus {
  authenticated,
  unauthenticated,
}

final class AppState extends Equatable {
  const AppState._({required this.status, this.accessToken});

  const AppState.authenticated(AccessToken accessToken)
      : this._(status: AppStatus.authenticated, accessToken: accessToken);

  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AccessToken? accessToken;
  final AppStatus status;
  @override
  List<Object> get props => [status];
}
