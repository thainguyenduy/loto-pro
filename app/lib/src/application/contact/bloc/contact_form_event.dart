part of 'contact_form_bloc.dart';

sealed class ContactFormEvent {}

final class ContactFormInitialized extends ContactFormEvent {
  Either<String, Contact> value;
  ContactFormInitialized(this.value);
}

final class ContactFormAutoParseFieldChanged extends ContactFormEvent {
  final bool changedMode;
  ContactFormAutoParseFieldChanged(this.changedMode);
}

final class ContactFormSaved extends ContactFormEvent {}
