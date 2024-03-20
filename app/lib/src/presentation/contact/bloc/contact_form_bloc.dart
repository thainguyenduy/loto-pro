import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ld_app/src/domain/contact/contact.dart';
import 'package:ld_app/src/domain/contact/contact_values.dart';
import 'package:ld_app/src/domain/core/value_objects/phone.dart';
import 'package:ld_app/src/domain/core/value_objects/unique_id.dart';
import 'package:ld_app/src/infrastructure/injector.dart';

part 'contact_form_event.dart';
part 'contact_form_state.dart';
part 'contact_form_bloc.freezed.dart';

class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  final ContactRepository contactRepository = locator<ContactRepository>();
  ContactFormBloc(Either<String, Contact> initial)
      : super(ContactFormState.initial(initial)) {
    on<ContactFormNameChanged>(_onContactFormNameChanged);
    on<ContactFormPhoneChanged>(_onContactFormPhoneChanged);
    on<ContactFormAutoParseChanged>(_onContactFormAutoParseChanged);
    on<ContactFormReplyModeChanged>(_onContactFormReplyModeChanged);
    on<ContactFormDebtReminderModeChanged>(
        _onContactFormDebtReminderModeChanged);
    on<ContactFormContactAliasChanged>(_onContactFormContactAliasChanged);
    on<ContactFormAccountAliasChanged>(_onContactFormAccountAliasChanged);
    on<ContactFormSaved>(_onContactFormSaved);
  }

  void _onContactFormNameChanged(
      ContactFormNameChanged event, Emitter<ContactFormState> emit) {}

  void _onContactFormPhoneChanged(
      ContactFormPhoneChanged event, Emitter<ContactFormState> emit) async {
    emit(state.copyWith(
      phone: event.phone,
      saveFailureOrSuccessOption: const None(),
    ));
  }

  void _onContactFormAutoParseChanged(
      ContactFormAutoParseChanged event, Emitter<ContactFormState> emit) {
    emit(state.copyWith(
        autoParse: event.autoParse, saveFailureOrSuccessOption: const None()));
  }

  void _onContactFormReplyModeChanged(
      ContactFormReplyModeChanged event, Emitter<ContactFormState> emit) {
    emit(state.copyWith(
        replyMode: event.replyMode, saveFailureOrSuccessOption: const None()));
  }

  void _onContactFormDebtReminderModeChanged(
      ContactFormDebtReminderModeChanged event,
      Emitter<ContactFormState> emit) {
    emit(state.copyWith(
        debtReminderMode: event.debtReminderMode,
        saveFailureOrSuccessOption: const None()));
  }

  void _onContactFormContactAliasChanged(
      ContactFormContactAliasChanged event, Emitter<ContactFormState> emit) {
    emit(state.copyWith(
        contactAlias: event.contactAlias,
        saveFailureOrSuccessOption: const None()));
  }

  void _onContactFormAccountAliasChanged(
      ContactFormAccountAliasChanged event, Emitter<ContactFormState> emit) {
    emit(state.copyWith(
        contactAlias: event.accountAlias,
        saveFailureOrSuccessOption: const None()));
  }

  void _onContactFormSaved(
      ContactFormSaved event, Emitter<ContactFormState> emit) async {
    Either<ContactFailure, Unit> failureOrSuccess;
    emit(state.copyWith(
      isSaving: true,
      saveFailureOrSuccessOption: const None(),
    ));

    failureOrSuccess = state.isEditing
        ? await contactRepository.update(state.contact).run()
        : await contactRepository.create(state.contact).run();
    emit(state.copyWith(
      isSaving: false,
      showErrorMessages: true,
      saveFailureOrSuccessOption: optionOf(failureOrSuccess),
    ));
  }
}
