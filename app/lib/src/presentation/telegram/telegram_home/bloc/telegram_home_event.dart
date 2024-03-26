part of 'telegram_home_bloc.dart';

sealed class TelegramHomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class TelegramHomeSubscriptionRequested extends TelegramHomeEvent {}

final class TelegramHomeSearchTyped extends TelegramHomeEvent {
  final String query;
  TelegramHomeSearchTyped(this.query);

  @override
  List<Object> get props => [query];
}

final class TelegramHomeFilterChanged extends TelegramHomeEvent {
  final ChatListFilter filter;
  TelegramHomeFilterChanged(this.filter);
  @override
  List<Object> get props => [filter];
}
