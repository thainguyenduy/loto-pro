part of 'telegram_authentication_bloc.dart';

enum TelegramAuthStatus {
  initial,
  waitPhoneNumber,
  waitCode,
  success,
  failure,
  loggedOut
}

@freezed
class TelegramAuthState with _$TelegramAuthState {
  const factory TelegramAuthState(
      {@Default(TelegramAuthStatus.initial) TelegramAuthStatus status,
      String? phone,
      String? code,
      String? errorMessage}) = _TelegramAuthState;
}
