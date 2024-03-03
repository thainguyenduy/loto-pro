import 'package:injectable/injectable.dart';
import 'package:ld_app/src/domain/contact/contact.dart';
import 'package:ld_app/src/domain/core/value_object.dart';
import 'package:ld_app/src/domain/core/value_objects/phone.dart';
import 'package:ld_app/src/infrastructure/mapper/i_mapper.dart';

import '../database/model/model.dart' as model;

@singleton
class ContactMapper implements IMapper<Contact, model.Contact> {
  @override
  model.Contact toDatasource(Contact domain) {
    return model.Contact.fromMap(domain.toMap());
  }

  @override
  Contact toDomain(model.Contact data) {
    return Contact(
        id: UniqueId.fromUniqueString(data.id!),
        telegramId: data.telegramId,
        phone: Phone(data.phone!),
        name: data.name!);
  }
}
