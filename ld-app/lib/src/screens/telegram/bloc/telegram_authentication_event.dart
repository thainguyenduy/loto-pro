part of 'telegram_authentication_bloc.dart';

sealed class TelegramAuthenticationEvent extends Equatable {
  const TelegramAuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class TelegramLogoutRequested extends TelegramAuthenticationEvent {
  const TelegramLogoutRequested();
}

final class _TelegramAuthStateChanged extends TelegramAuthenticationEvent {
  const _TelegramAuthStateChanged(this.status);
  final td.AuthorizationState status;
}

final class TelegramAuthPhoneNumberSubmitted
    extends TelegramAuthenticationEvent {
  const TelegramAuthPhoneNumberSubmitted(this.phone);
  final String phone;
}

final class TelegramAuthPasswordSubmitted extends TelegramAuthenticationEvent {
  const TelegramAuthPasswordSubmitted(this.password);
  final String password;
}

final class TelegramAuthReady extends TelegramAuthenticationEvent {}

final class TelegramAuthCodeSubmitted extends TelegramAuthenticationEvent {
  const TelegramAuthCodeSubmitted(this.code);
  final String code;
}
