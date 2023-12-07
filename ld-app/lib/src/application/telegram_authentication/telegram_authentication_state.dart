part of 'telegram_authentication_bloc.dart';

sealed class TelegramAuthenticationState extends Equatable {
  const TelegramAuthenticationState();
  
  @override
  List<Object> get props => [];
}

final class TelegramAuthenticationInitial extends TelegramAuthenticationState {}
