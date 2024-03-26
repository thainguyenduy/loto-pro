import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ld_app/src/domain/message.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:ld_app/src/infrastructure/injector.dart';
import 'package:ld_app/src/infrastructure/service/telegram_service.dart';

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
  }
  Future<void> _onSubscriptionRequested(
    TelegramHomeSubscriptionRequested event,
    Emitter<TelegramHomeState> emit,
  ) async {
    emit(state.copyWith(status: TelegramHomeStatus.loading));

    await emit.forEach<List<Chat>>(
      service.updates
          .where((td.TdObject event) => event is td.UpdateNewMessage)
          .map((td.Message message) =>
              TextMessage.fromTdlib(message, service.me!)),
      onData: (chats) => state.copyWith(
        status: TelegramHomeStatus.success,
        chats: chats,
      ),
      onError: (_, __) => state.copyWith(
        status: TelegramHomeStatus.failure,
      ),
    );
  }
}
