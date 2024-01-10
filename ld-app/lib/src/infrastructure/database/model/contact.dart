import 'package:ld_app/src/infrastructure/database/model/account.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

const tableContact = SqfEntityTable(
  tableName: 'contact',
  primaryKeyName: 'id',
  primaryKeyType: PrimaryKeyType.text,
  useSoftDeleting: false,
  // when useSoftDeleting is true, creates a field named 'isDeleted' on the table, and set to '1' this field when item deleted (does not hard delete)
  modelName:
      null, // SqfEntity will set it to TableName automatically when the modelName (class name) is null
  // declare fields
  fields: [
    SqfEntityField('telegramId', DbType.text, isNotNull: true),
    SqfEntityField('name', DbType.text, isNotNull: true),
    SqfEntityField('phone', DbType.text, isNotNull: true),
    SqfEntityFieldRelationship(
      parentTable: tableAccount,
      fieldName: 'accountId',
      deleteRule: DeleteRule.NO_ACTION,
    ),
  ],
);
