import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tdlib/td_api.dart' as td;
import 'package:tdlib/td_client.dart';
import 'package:path_provider/path_provider.dart';

part 'telegram_authentication_event.dart';
part 'telegram_authentication_state.dart';
part 'telegram_authentication_bloc.freezed.dart';

@lazySingleton
class TelegramAuthenticationBloc
    extends Bloc<TelegramAuthenticationEvent, TelegramAuthState> {
  TelegramAuthenticationBloc() : super(const TelegramAuthState()) {
    on<_TelegramAuthStateChanged>(_onTelegramAuthStateChanged);
    on<TelegramLogoutRequested>(_onTelegramLogoutRequested);
    on<TelegramAuthPhoneNumberSubmitted>(_onTelegramAuthPhoneNumberSubmitted);
    on<TelegramAuthCodeSubmitted>(_onTelegramAuthCodeSubmitted);
    telegramClient = Client.create();
    // if (_eventsSubscription != null) _eventsSubscription?.cancel();
    _eventsSubscription = telegramClient?.updates.listen(_onNewEvent);
    telegramClient?.initialize();
  }
  late final Client? telegramClient;
  late StreamSubscription<td.TdObject>? _eventsSubscription;
  Future<void> _onTelegramAuthStateChanged(
      _TelegramAuthStateChanged event, Emitter<TelegramAuthState> emit) async {
    if (event.status is td.AuthorizationStateWaitTdlibParameters) {
      await telegramClient?.send(
        td.SetTdlibParameters(
          systemVersion: '',
          useTestDc: true,
          useSecretChats: false,
          useMessageDatabase: true,
          useFileDatabase: true,
          useChatInfoDatabase: true,
          ignoreFileNames: true,
          enableStorageOptimizer: true,
          filesDirectory: await _getFilesDirectory(),
          databaseDirectory: await _getDatabaseDirectory(),
          systemLanguageCode: 'en',
          deviceModel: 'unknown',
          applicationVersion: '1.0.0',
          apiId: 23305343,
          apiHash: '65b8c22115224d72ed65c5290d687975',
          databaseEncryptionKey: '',
        ),
      );
    } else if (event.status is td.AuthorizationStateWaitPhoneNumber) {
      emit(state.copyWith(status: TelegramAuthStatus.waitPhoneNumber));
    } else if (event.status is td.AuthorizationStateWaitCode) {
      emit(state.copyWith(status: TelegramAuthStatus.waitCode));
    } else if (event.status is td.AuthorizationStateReady) {
      emit(state.copyWith(status: TelegramAuthStatus.success));
    } else {
      emit(state.copyWith(status: TelegramAuthStatus.failure));
    }
  }

  Future<void> _onTelegramAuthPhoneNumberSubmitted(
      TelegramAuthPhoneNumberSubmitted event,
      Emitter<TelegramAuthState> emit) async {
    await telegramClient?.send(td.SetAuthenticationPhoneNumber(
        phoneNumber: event.phone)); /* '9996621234' */
    emit(state.copyWith(phone: event.phone));
  }

  Future<void> _onTelegramAuthCodeSubmitted(
      TelegramAuthCodeSubmitted event, Emitter<TelegramAuthState> emit) async {
    await telegramClient
        ?.send(td.CheckAuthenticationCode(code: event.code)); // '22222'
    emit(state.copyWith(code: event.code));
  }

  Future<void> _onTelegramLogoutRequested(
      TelegramLogoutRequested event, Emitter<TelegramAuthState> emit) async {
    await telegramClient?.send(const td.LogOut());
  }

  @override
  close() async {
    super.close();
    telegramClient?.destroy();
    await _eventsSubscription?.cancel();
    telegramClient = null;
  }

  void _onNewEvent(td.TdObject event) async {
    if (event is td.UpdateAuthorizationState) {
      add(_TelegramAuthStateChanged(event.authorizationState));
    }
  }

  Future<String> _getFilesDirectory() async {
    if (kIsWeb) {
      return 'files';
    }
    final Directory applicationSupportDirectory =
        await getApplicationSupportDirectory();

    return '${applicationSupportDirectory.path}/files';
  }

  Future<String> _getDatabaseDirectory() async {
    if (kIsWeb) {
      return 'database';
    }
    final Directory applicationSupportDirectory =
        await getApplicationSupportDirectory();

    return '${applicationSupportDirectory.path}/database';
  }
}
