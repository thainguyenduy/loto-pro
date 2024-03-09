import 'package:injectable/injectable.dart';
import 'package:ld_app/src/domain/contact/contact.dart';
import 'package:ld_app/src/domain/contact/contact_values.dart';
import 'package:ld_app/src/domain/core/value_objects/phone.dart';
import 'package:ld_app/src/domain/core/value_objects/unique_id.dart';
import 'package:ld_app/src/infrastructure/mapper/i_mapper.dart';

import '../database/model/model.dart' as model;

@singleton
class ContactMapper implements IMapper<Contact, model.Contact> {
  @override
  model.Contact toDatasource(Contact domain) {
    return model.Contact.fromMap(domain.toJson());
  }

  @override
  Contact toDomain(model.Contact data) {
    return Contact(
        id: UniqueId.fromUniqueString(data.id!),
        name: data.name!,
        phone: Phone(data.phone!),
        chatId: data.chatId!,
        isAutoParse: true,
        replyMode: ReplyMode.fromKey(data.replyMode!),
        debtReminderMode: DebtReminderMode.fromKey(data.debtReminderMode!),
        telegramId: data.telegramId,
        contactAlias: data.contactAlias,
        accountAlias: data.accountAlias);
  }
}
