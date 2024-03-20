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
    required bool loCurrencyUnitAsThousandVND,
    required bool deCurrencyUnitAsThousandVND,
    required bool rejectedOvertimeBet,
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
      autoParse: autoParse,
      replyMode: replyMode,
      debtReminderMode: debtReminderMode,
      loCurrencyUnitAsThousandVND: loCurrencyUnitAsThousandVND,
      deCurrencyUnitAsThousandVND: deCurrencyUnitAsThousandVND,
      rejectedOvertimeBet: rejectedOvertimeBet,
      contactAlias: contactAlias,
      accountAlias: accountAlias,
      telegramId: telegramId);
  factory ContactFormState.fromContact(Contact contact, bool isEditing) =>
      ContactFormState(
          id: contact.id,
          name: contact.name,
          phone: contact.phone,
          chatId: contact.chatId,
          autoParse: contact.autoParse,
          replyMode: contact.replyMode,
          debtReminderMode: contact.debtReminderMode,
          loCurrencyUnitAsThousandVND: contact.loCurrencyUnitAsThousandVND,
          deCurrencyUnitAsThousandVND: contact.deCurrencyUnitAsThousandVND,
          rejectedOvertimeBet: contact.rejectedOvertimeBet,
          contactAlias: contact.contactAlias,
          accountAlias: contact.accountAlias,
          telegramId: contact.telegramId,
          showErrorMessages: false,
          isEditing: isEditing,
          isSaving: false,
          saveFailureOrSuccessOption: none());
}
