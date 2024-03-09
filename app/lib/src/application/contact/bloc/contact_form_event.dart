part of 'contact_form_bloc.dart';

sealed class ContactFormEvent {}

final class ContactFormAutoParseChanged extends ContactFormEvent {
  final bool autoParse;
  ContactFormAutoParseChanged(this.autoParse);
}

final class ContactFormReplyModeChanged extends ContactFormEvent {
  final int replyMode;
  ContactFormReplyModeChanged(this.replyMode);
}

final class ContactFormDebtReminderModeChanged extends ContactFormEvent {
  final int debtReminderMode;
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

final class ContactFormSaved extends ContactFormEvent {}
