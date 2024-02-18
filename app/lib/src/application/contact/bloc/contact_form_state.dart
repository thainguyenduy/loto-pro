part of 'contact_form_bloc.dart';

@freezed
class ContactFormState with _$ContactFormState {
   factory ContactFormState({
    @required Contact contact,
    @required bool showErrorMessages,
    @required bool isEditing,
    @required bool isSaving,
    @required Option<Either<ContactFailure, Unit>> saveFailureOrSuccessOption,
  })
  const factory ContactFormState.initial(Contact contact, bool isEditing) = ContactFormState(
    contact: contact,
    showErrorMessages: false,
    isEditing: isEditing,
    isSaving: false,
    saveFailureOrSuccessOption: none()
  );
}
