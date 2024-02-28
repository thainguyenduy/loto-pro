part of 'contact_form_bloc.dart';

@freezed
class ContactFormState with _$ContactFormState {
  const factory ContactFormState({
    required Contact contact,
    required bool showErrorMessages,
    required bool isEditing,
    required bool isSaving,
    required Option<Either<ContactFailure, Unit>> saveFailureOrSuccessOption,
  }) = _ContactFormState;
  factory ContactFormState.create(String chatId) => ContactFormState(
      contact: Contact.fromChat(chatId: chatId),
      showErrorMessages: false,
      isEditing: false,
      isSaving: false,
      saveFailureOrSuccessOption: none());
}
