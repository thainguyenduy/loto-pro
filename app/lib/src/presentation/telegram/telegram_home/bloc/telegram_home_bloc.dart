import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:ld_app/src/infrastructure/service/telegram_service.dart';
import 'package:ld_app/src/infrastructure/utils/debounce.dart';

import '../../../../domain/chat.dart';

part 'telegram_home_event.dart';
part 'telegram_home_state.dart';
part 'telegram_home_bloc.freezed.dart';

class TelegramHomeBloc extends Bloc<TelegramHomeEvent, TelegramHomeState> {
  final TelegramService service;
  TelegramHomeBloc()
      : service = locator<TelegramService>(),
        super(TelegramHomeState.initial()) {
    on<TelegramHomeSubscriptionRequested>(_onSubscriptionRequested);
    on<TelegramHomeSearchTyped>(
      _onTelegramHomeSearchTyped,
      transformer: debounce(duration: const Duration(milliseconds: 300)),
    );
    on<TelegramHomeFilterChanged>(_onTelegramHomeFilterChanged);
  }
  Future<void> _onSubscriptionRequested(
    TelegramHomeSubscriptionRequested event,
    Emitter<TelegramHomeState> emit,
  ) async {
    emit(state.copyWith(status: TelegramHomeStatus.loading));
    await emit.forEach<List<Chat>>(
      service.streamChatList,
      onData: (chats) => state.copyWith(
        status: TelegramHomeStatus.success,
        chats: chats,
      ),
      onError: (_, __) => state.copyWith(
        status: TelegramHomeStatus.failure,
      ),
    );
  }

  Future<void> _onTelegramHomeSearchTyped(
      TelegramHomeSearchTyped event, Emitter<TelegramHomeState> emit) async {
    emit(state.copyWith(
        query: event.query,
        chats: state.chats
          ..where((chat) => chat.title.toLowerCase().contains(event.query))));
  }

  Future<void> _onTelegramHomeFilterChanged(
      TelegramHomeFilterChanged event, Emitter<TelegramHomeState> emit) async {
    emit(state.copyWith(
        filter: event.filter, status: TelegramHomeStatus.loading));
    //TODO get Stream List<Chat> coresponding to filter value
  }
}
