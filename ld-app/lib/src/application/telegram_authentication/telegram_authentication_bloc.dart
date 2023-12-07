import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'telegram_authentication_event.dart';
part 'telegram_authentication_state.dart';
@singleton
class TelegramAuthenticationBloc extends Bloc<TelegramAuthenticationEvent, TelegramAuthenticationState> {
  TelegramAuthenticationBloc() : super(TelegramAuthenticationInitial()) {
    on<TelegramAuthenticationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
