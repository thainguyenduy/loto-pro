part of 'contact.dart';

abstract interface class ContactRepository {
  TaskEither<ContactFailure, Contact> getContact(String id);
  TaskEither<ContactFailure, KtList<Contact>> getContactsByAccountId(
      String accountId);
  TaskEither<ContactFailure, Unit> create(Contact contact);
  TaskEither<ContactFailure, Unit> update(Contact contact);
  TaskEither<ContactFailure, Unit> delete(Contact contact);
}
