import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/collection.dart';
import 'package:ld_app/src/domain/contact/contact.dart';

import 'package:ld_app/src/infrastructure/database/model/model.dart' as model;
import 'package:ld_app/src/infrastructure/mapper/contact_mapper.dart';

@LazySingleton(as: ContactRepository)
final class ContactRepositoryImpl implements ContactRepository {
  final ContactMapper contactMapper;
  ContactRepositoryImpl(this.contactMapper);

  @override
  TaskEither<ContactFailure, Unit> create(Contact contact) {
    return TaskEither.tryCatch(
        () => model.Contact.fromMap(contact.toJson()).save(),
        (error, stackTrace) => ContactCreatedFailure()).map((r) => unit);
  }

  @override
  TaskEither<ContactFailure, Unit> delete(Contact contact) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  TaskEither<ContactFailure, Unit> update(Contact contact) {
    return TaskEither.tryCatch(
        () => model.Contact.fromMap(contact.toJson()).save(),
        (error, stackTrace) => ContactUpdatedFailure()).map((r) => unit);
  }

  @override
  TaskEither<ContactFailure, Contact> getContact(String id) {
    final conMayNullTE = TaskEither.tryCatch(() => model.Contact().getById(id),
        (_, __) => ContactDataAccessFailure());
    TaskEither<ContactFailure, model.Contact> conTE(model.Contact? acc) =>
        TaskEither.fromNullable(acc, () => ContactNotFoundFailure());
    IOEither<ContactFailure, Contact> modelToDomainIOE(model.Contact acc) =>
        IOEither.tryCatch(() => contactMapper.toDomain(acc),
            (_, __) => ContactDomainFailure());
    final res = conMayNullTE
        .flatMap(conTE as TaskEither<ContactDataAccessFailure, dynamic>
            Function(model.Contact? r))
        .flatMap(modelToDomainIOE
            as TaskEither<ContactDataAccessFailure, dynamic> Function(
                dynamic r))
        .map((r) => r as Contact);
    return res;
  }
  
  @override
  TaskEither<ContactFailure, KtList<Contact>> getContactsByAccountId(String accountId) {
    // TODO: implement getContactsByAccountId
    throw UnimplementedError();
  }
}
