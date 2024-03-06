part of 'contact_form_bloc.dart';

sealed class ContactFormEvent {}

final class ContactFormInitialized extends ContactFormEvent {
  Either<String, Contact> value;
  ContactFormInitialized(this.value);
}

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

final class ContactFormSaved extends ContactFormEvent {}
