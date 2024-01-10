import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqfentity/sqfentity.dart';
import 'package:sqfentity_gen/sqfentity_gen.dart';

import 'package:ld_app/src/infrastructure/database/model/account.dart';
import 'package:ld_app/src/infrastructure/database/model/contact.dart';

part 'model.g.dart';

// Define the 'identity' constant as SqfEntitySequence.
const seqIdentity = SqfEntitySequence(
  sequenceName: 'identity',
  //maxValue:  10000, /* optional. default is max int (9.223.372.036.854.775.807) */
  //modelName: 'SQEidentity',
  /* optional. SqfEntity will set it to sequenceName automatically when the modelName is null*/
  //cycle : false,    /* optional. default is false; */
  //minValue = 0;     /* optional. default is 0 */
  //incrementBy = 1;  /* optional. default is 1 */
  // startWith = 0;   /* optional. default is 0 */
);

@SqfEntityBuilder(lddbModel)
const lddbModel = SqfEntityModel(
    modelName: 'LDModel',
    databaseName: 'lddb.db',
    password:
        null, // You can set a password if you want to use crypted database (For more information: https://github.com/sqlcipher/sqlcipher)
    // put defined tables into the tables list.
    databaseTables: [tableContact, tableAccount],
    // put defined sequences into the sequences list.
    sequences: [seqIdentity],
    dbVersion: 2,
    // This value is optional. When bundledDatabasePath is empty then
    // EntityBase creats a new database when initializing the database
    bundledDatabasePath: null, //         'assets/sample.db'
    // This value is optional. When databasePath is null then
    // EntityBase uses the default path from sqflite.getDatabasesPath()
    // If you want to set a physically path just set a directory like: '/Volumes/Repo/MyProject/db',
    databasePath: null,
    defaultColumns: [
      SqfEntityField('dateCreated', DbType.datetime,
          defaultValue: 'DateTime.now()'),
    ]);
