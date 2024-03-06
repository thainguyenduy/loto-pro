import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ld_app/src/domain/contact/contact.dart';
import 'package:ld_app/src/domain/contact/contact_values.dart';
import 'package:ld_app/src/domain/core/value_object.dart';
import 'package:ld_app/src/domain/core/value_objects/phone.dart';
import 'package:ld_app/src/domain/core/value_objects/unique_id.dart';

part 'contact_form_event.dart';
part 'contact_form_state.dart';
part 'contact_form_bloc.freezed.dart';

@injectable
class ContactFormBloc extends Bloc<ContactFormEvent, ContactFormState> {
  final ContactRepository contactRepository;
  ContactFormBloc(this.contactRepository) : super(ContactFormState.initial()) {
    on<ContactFormInitialized>(_onContactFormInitialized);
    on<ContactFormAutoParseChanged>(_onContactFormAutoParseChanged);
    on<ContactFormReplyModeChanged>(_onContactFormReplyModeChanged);
    on<ContactFormDebtReminderModeChanged>(
        _onContactFormDebtReminderModeChanged);
    on<ContactFormSaved>(_onContactFormSaved);
  }

  void _onContactFormInitialized(
      ContactFormInitialized event, Emitter<ContactFormState> emit) {
    Contact contact = event.value
        .match((String chatId) => Contact.fromChat(chatId: chatId), identity);
    emit(ContactFormState.fromContact(contact));
    /* emit(state.copyWith(
        contact:
            event.value.getOrElse((chatId) => Contact.fromChat(chatId: chatId)),
        saveFailureOrSuccessOption: const None())); */
  }

  void _onContactFormAutoParseChanged(
      ContactFormAutoParseChanged event, Emitter<ContactFormState> emit) {
    emit(state.copyWith(
        autoParse: event.autoParse, saveFailureOrSuccessOption: const None()));
  }

  void _onContactFormReplyModeChanged(
      ContactFormReplyModeChanged event, Emitter<ContactFormState> emit) {
    emit(state.copyWith(
        replyMode: ReplyMode.fromKey(event.replyMode),
        saveFailureOrSuccessOption: const None()));
  }

  void _onContactFormDebtReminderModeChanged(
      ContactFormDebtReminderModeChanged event,
      Emitter<ContactFormState> emit) {
    emit(state.copyWith(
        debtReminderMode: DebtReminderMode.fromKey(event.debtReminderMode),
        saveFailureOrSuccessOption: const None()));
  }

  void _onContactFormSaved(
      ContactFormSaved event, Emitter<ContactFormState> emit) async {
    Either<ContactFailure, Unit> failureOrSuccess;
    emit(state.copyWith(
      isSaving: true,
      saveFailureOrSuccessOption: const None(),
    ));

    //TODO check state.isEditing
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
