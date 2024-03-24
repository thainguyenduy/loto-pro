import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tdlib/td_api.dart';

part 'telegram_home_event.dart';
part 'telegram_home_state.dart';
part 'telegram_home_bloc.freezed.dart';

class TelegramHomeBloc extends Bloc<TelegramHomeEvent, TelegramHomeState> {
  TelegramHomeBloc() : super(_Initial()) {
    on<TelegramHomeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
