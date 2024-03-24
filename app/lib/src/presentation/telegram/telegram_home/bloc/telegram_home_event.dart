part of 'telegram_home_bloc.dart';

@freezed
class TelegramHomeEvent with _$TelegramHomeEvent {
  const factory TelegramHomeEvent.started() = _Started;
}