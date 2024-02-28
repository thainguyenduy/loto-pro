part of 'contact.dart';

abstract class ContactFailure {}

class ContactDataAccessFailure extends ContactFailure {}

class ContactNotFoundFailure extends ContactFailure {}

class ContactDomainFailure extends ContactFailure {}

class ContactCreatedFailure extends ContactFailure {}

class ContactUpdatedFailure extends ContactFailure {}
