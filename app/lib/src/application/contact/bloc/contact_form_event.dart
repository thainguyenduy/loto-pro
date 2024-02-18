part of 'contact_form_bloc.dart';

sealed class ContactFormEvent {}

final class ContactFormEventInitialized extends ContactFormEvent {
  Option<Contact> contact;
  ContactFormEventInitialized(this.contact);
}
