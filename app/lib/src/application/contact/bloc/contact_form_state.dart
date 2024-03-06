part of 'contact_form_bloc.dart';

@freezed
class ContactFormState with _$ContactFormState {
  const ContactFormState._();
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
  factory ContactFormState.initial() => ContactFormState(
      id: UniqueId(),
      name: '',
      phone: Phone(''),
      chatId: '',
      autoParse: false,
      replyMode: ReplyMode.khongTraLoi,
      debtReminderMode: DebtReminderMode.baoKemNoCuChiTiet,
      contactAlias: null,
      accountAlias: null,
      telegramId: null,
      showErrorMessages: false,
      isEditing: false,
      isSaving: false,
      saveFailureOrSuccessOption: none());
  Contact get contact => Contact(
      id: id,
      name: name,
      phone: phone,
      chatId: chatId,
      autoParse: autoParse,
      replyMode: replyMode,
      debtReminderMode: debtReminderMode,
      contactAlias: contactAlias,
      accountAlias: accountAlias,
      telegramId: telegramId);
  factory ContactFormState.fromContact(Contact contact) => ContactFormState(
      id: contact.id,
      name: contact.name,
      phone: contact.phone,
      chatId: contact.chatId,
      autoParse: contact.autoParse,
      replyMode: contact.replyMode,
      debtReminderMode: contact.debtReminderMode,
      contactAlias: contact.contactAlias,
      accountAlias: contact.accountAlias,
      telegramId: contact.telegramId,
      showErrorMessages: false,
      isEditing: false,
      isSaving: false,
      saveFailureOrSuccessOption: none());
}
