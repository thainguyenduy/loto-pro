part of 'contact.dart';

abstract interface class ContactRepository {
  TaskEither<ContactFailure, Contact> getContact(String id);
  TaskEither<ContactFailure, Unit> create(Contact contact);
  TaskEither<ContactFailure, Unit> update(Contact contact);
  TaskEither<ContactFailure, Unit> delete(Contact contact);
}
