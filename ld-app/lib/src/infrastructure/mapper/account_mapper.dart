import 'package:injectable/injectable.dart';
import 'package:ld_app/src/domain/account/account.dart';
import 'package:ld_app/src/domain/contact/contact.dart';
import 'package:ld_app/src/domain/core/value_object.dart';
import 'package:ld_app/src/domain/value_objects/phone.dart';
import 'package:ld_app/src/infrastructure/mapper/contact_mapper.dart';
import 'package:ld_app/src/infrastructure/mapper/i_mapper.dart';

import '../database/model/model.dart' as model;

@singleton
class AccountMapper implements IMapper<Account, model.Account> {
  final ContactMapper contactMapper;
  AccountMapper(this.contactMapper);
  @override
  model.Account toDatasource(Account domain) {
    // TODO: implement toDatasource
    return model.Account.fromMap(domain.toMap());
  }

  @override
  Account toDomain(model.Account data) {
    final List<Contact> contacts = data.plContacts != null
        ? data.plContacts!
            .map((model.Contact contact) => contactMapper.toDomain(contact))
            .toList()
        : [];
    return Account(
        id: UniqueId.fromUniqueString(data.id!),
        deviceId: data.deviceId!,
        telegramId: data.telegramId,
        phone: Phone(data.phone!),
        contacts: contacts);
  }
}
