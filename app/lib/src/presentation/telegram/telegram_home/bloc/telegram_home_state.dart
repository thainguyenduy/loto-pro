part of 'telegram_home_bloc.dart';

enum ChatListTypeEnum { all, contactOnly, betting }

@freezed
class TelegramHomeState with _$TelegramHomeState {
  const factory TelegramHomeState.initial() = _Initial;
  const factory TelegramHomeState({
    String? query,
    required List<Chat> chats,
    required ChatListTypeEnum filter,
  }) = _TelegramHomeState;
}
