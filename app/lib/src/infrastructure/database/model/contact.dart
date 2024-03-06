part of 'model.dart';

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
    SqfEntityField('chatId', DbType.text, isNotNull: true),
    SqfEntityField('autoParse', DbType.bool,
        isNotNull: true, defaultValue: false),
    SqfEntityField('accountAlias', DbType.text, isNotNull: false),
    SqfEntityField('contactAlias', DbType.text, isNotNull: false),
    SqfEntityField('replyMode', DbType.integer,
        isNotNull: true, defaultValue: 0),
    SqfEntityField('debtReminderMode', DbType.integer,
        isNotNull: true, defaultValue: 0),
    SqfEntityFieldRelationship(
      parentTable: tableAccount,
      relationType: RelationType.ONE_TO_MANY,
      deleteRule: DeleteRule.NO_ACTION,
    ),
  ],
);
