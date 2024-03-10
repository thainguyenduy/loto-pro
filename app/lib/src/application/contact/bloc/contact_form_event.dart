part of 'contact_form_bloc.dart';

sealed class ContactFormEvent {}

final class ContactFormNameChanged extends ContactFormEvent {
  final String name;
  ContactFormNameChanged(this.name);
}

final class ContactFormPhoneChanged extends ContactFormEvent {
  final Phone phone;
  ContactFormPhoneChanged(this.phone);
}
final class ContactFormAutoParseChanged extends ContactFormEvent {
  final bool autoParse;
  ContactFormAutoParseChanged(this.autoParse);
}

final class ContactFormReplyModeChanged extends ContactFormEvent {
  final ReplyMode replyMode;
  ContactFormReplyModeChanged(this.replyMode);
}

final class ContactFormDebtReminderModeChanged extends ContactFormEvent {
  final DebtReminderMode debtReminderMode;
  ContactFormDebtReminderModeChanged(this.debtReminderMode);
}

final class ContactFormLoCurrencyUnitIsThousandVNDChanged
    extends ContactFormEvent {
  final bool loCurrencyUnitIsThousandVND;
  ContactFormLoCurrencyUnitIsThousandVNDChanged(
      this.loCurrencyUnitIsThousandVND);
}

final class ContactFormDeCurrencyUnitIsThousandVNDChanged
    extends ContactFormEvent {
  final bool deCurrencyUnitIsThousandVND;
  ContactFormDeCurrencyUnitIsThousandVNDChanged(
      this.deCurrencyUnitIsThousandVND);
}

final class ContactFormRejectedOvertimeBetChanged extends ContactFormEvent {
  final bool rejectedOvertimeBet;
  ContactFormRejectedOvertimeBetChanged(this.rejectedOvertimeBet);
}

final class ContactFormContactAliasChanged extends ContactFormEvent {
  final String contactAlias;
  ContactFormContactAliasChanged(this.contactAlias);
}

final class ContactFormAccountAliasChanged extends ContactFormEvent {
  final String accountAlias;
  ContactFormAccountAliasChanged(this.accountAlias);
}
final class ContactFormSaved extends ContactFormEvent {}
