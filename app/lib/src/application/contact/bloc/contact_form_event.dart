part of 'contact_form_bloc.dart';

sealed class ContactFormEvent {}

final class ContactFormInitialized extends ContactFormEvent {
  Either<String, Contact> value;
  ContactFormInitialized(this.value);
}

final class ContactFormChanged extends ContactFormEvent {
  final Contact contact;
  ContactFormChanged(this.contact);
}

final class ContactFormSaved extends ContactFormEvent {}
