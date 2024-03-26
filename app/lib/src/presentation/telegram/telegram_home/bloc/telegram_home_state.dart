part of 'telegram_home_bloc.dart';

enum ChatListFilter { all, allContact, bettingOnly }

enum TelegramHomeStatus { initial, loading, success, failure }

@freezed
class TelegramHomeState with _$TelegramHomeState {
  factory TelegramHomeState.initial() => const TelegramHomeState(
      chats: [],
      filter: ChatListFilter.all,
      status: TelegramHomeStatus.initial);
  const factory TelegramHomeState({
    required TelegramHomeStatus status,
    String? query,
    required List<Chat> chats,
    required ChatListFilter filter,
  }) = _TelegramHomeState;
}
