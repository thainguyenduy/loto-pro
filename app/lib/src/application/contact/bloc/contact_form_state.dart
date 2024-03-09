part of 'contact_form_bloc.dart';

@freezed
class ContactFormState with _$ContactFormState {
  const ContactFormState._();
  factory ContactFormState.initial(Either<String, Contact> initial) {
    Contact contact = initial.match(
        (String chatId) => Contact.fromChat(chatId: chatId), identity);
    return ContactFormState.fromContact(
        contact, initial.isLeft() ? false : true);
  }
  const factory ContactFormState({
    required UniqueId id,
    required String name,
    required Phone phone,
    required String chatId,
    required bool autoParse,
    required ReplyMode replyMode,
    required DebtReminderMode debtReminderMode,
    String? contactAlias,
    String? accountAlias,
    String? telegramId,
    required bool showErrorMessages,
    required bool isEditing,
    required bool isSaving,
    required Option<Either<ContactFailure, Unit>> saveFailureOrSuccessOption,
  }) = _ContactFormState;
  Contact get contact => Contact(
      id: id,
      name: name,
      phone: phone,
      chatId: chatId,
      isAutoParse: autoParse,
      replyMode: replyMode,
      debtReminderMode: debtReminderMode,
      contactAlias: contactAlias,
      accountAlias: accountAlias,
      telegramId: telegramId);
  factory ContactFormState.fromContact(Contact contact, bool isEditing) =>
      ContactFormState(
          id: contact.id,
          name: contact.name,
          phone: contact.phone,
          chatId: contact.chatId,
          autoParse: contact.isAutoParse,
          replyMode: contact.replyMode,
          debtReminderMode: contact.debtReminderMode,
          contactAlias: contact.contactAlias,
          accountAlias: contact.accountAlias,
          telegramId: contact.telegramId,
          showErrorMessages: false,
          isEditing: isEditing,
          isSaving: false,
          saveFailureOrSuccessOption: none());
}
