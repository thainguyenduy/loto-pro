part of 'telegram_home_bloc.dart';

sealed class TelegramHomeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class TelegramHomeSubscriptionRequested extends TelegramHomeEvent {}
