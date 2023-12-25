part of 'telegram_authentication_bloc.dart';

enum TelegramAuthStatus {
  initial,
  waitPhoneNumber,
  waitCode,
  waitPassword,
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
      String? password,
      String? errorMessage}) = _TelegramAuthState;
}
