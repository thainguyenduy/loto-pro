import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:ld_app/src/infrastructure/service/telegram_service.dart';
import 'package:tdlib/td_api.dart' as td;

part 'telegram_authentication_event.dart';
part 'telegram_authentication_state.dart';
part 'telegram_authentication_bloc.freezed.dart';

@lazySingleton
class TelegramAuthenticationBloc
    extends Bloc<TelegramAuthenticationEvent, TelegramAuthState> {
  TelegramAuthenticationBloc(this.service) : super(const TelegramAuthState()) {
    on<_TelegramAuthStateChanged>(_onTelegramAuthStateChanged);
    on<TelegramLogoutRequested>(_onTelegramLogoutRequested);
    on<TelegramAuthPhoneNumberSubmitted>(_onTelegramAuthPhoneNumberSubmitted);
    on<TelegramAuthCodeSubmitted>(_onTelegramAuthCodeSubmitted);
    on<TelegramAuthPasswordSubmitted>(_onTelegramAuthPasswordSubmitted);
    on<TelegramAuthReady>(_onTelegramAuthReady);
    // if (_eventsSubscription != null) _eventsSubscription.cancel();
    _eventsSubscription = service.updates.listen(_onNewEvent);
  }
  late final TelegramService service;
  late StreamSubscription<td.TdObject> _eventsSubscription;
  Future<void> _onTelegramAuthStateChanged(
      _TelegramAuthStateChanged event, Emitter<TelegramAuthState> emit) async {
    if (event.status is td.AuthorizationStateWaitTdlibParameters) {
      final result = await service.setTdlibParameters();
      if (result is td.TdError) {
        debugPrint('$result');
      }
    } else if (event.status is td.AuthorizationStateWaitPhoneNumber) {
      emit(state.copyWith(status: TelegramAuthStatus.waitPhoneNumber));
    } else if (event.status is td.AuthorizationStateWaitCode) {
      emit(state.copyWith(status: TelegramAuthStatus.waitCode));
    } else if (event.status is td.AuthorizationStateWaitPassword) {
      emit(state.copyWith(status: TelegramAuthStatus.waitPassword));
    } else if (event.status is td.AuthorizationStateReady) {
      add(TelegramAuthReady());
      emit(state.copyWith(status: TelegramAuthStatus.success));
    } else if (event.status is td.AuthorizationStateClosing) {
      debugPrint('$event');
    } else if (event.status is td.AuthorizationStateClosed) {
      debugPrint('$event');
    } else {
      emit(state.copyWith(status: TelegramAuthStatus.failure));
    }
  }

  Future<void> _onTelegramAuthPhoneNumberSubmitted(
      TelegramAuthPhoneNumberSubmitted event,
      Emitter<TelegramAuthState> emit) async {
    final res = await service
        .setAuthenticationPhoneNumber(event.phone); /* '9996621234' */
    if (res is td.Ok) emit(state.copyWith(phone: event.phone));
  }

  Future<void> _onTelegramAuthCodeSubmitted(
      TelegramAuthCodeSubmitted event, Emitter<TelegramAuthState> emit) async {
    final res = await service.checkAuthenticationCode(event.code); // '22222'
    if (res is td.Ok) emit(state.copyWith(code: event.code));
  }

  Future<void> _onTelegramAuthPasswordSubmitted(
      TelegramAuthPasswordSubmitted event,
      Emitter<TelegramAuthState> emit) async {
    final res =
        await service.checkAuthenticationPassword(event.password); // '22222'
    if (res is td.Ok) emit(state.copyWith(password: event.password));
  }

  Future<void> _onTelegramLogoutRequested(
      TelegramLogoutRequested event, Emitter<TelegramAuthState> emit) async {
    final res = await service.logOut();
    if (res is td.Ok) {
      emit(state.copyWith(status: TelegramAuthStatus.loggedOut));
    }
  }

  Future<void> _onTelegramAuthReady(
      TelegramAuthReady event, Emitter<TelegramAuthState> emit) async {
    await service.getMe();
  }

  @override
  close() async {
    super.close();
    await _eventsSubscription.cancel();
  }

  void _onNewEvent(td.TdObject event) async {
    if (event is td.UpdateAuthorizationState) {
      add(_TelegramAuthStateChanged(event.authorizationState));
    }
  }
}
