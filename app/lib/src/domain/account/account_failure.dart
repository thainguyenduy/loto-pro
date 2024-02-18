part of 'account.dart';

sealed class AccountFailure {}

class AccountDataAccessFailure extends AccountFailure {}

class AccountNotFoundFailure extends AccountFailure {}

class AccountDomainFailure extends AccountFailure {}

class AccountCreatedFailure extends AccountFailure {}

class AccountUpdatedFailure extends AccountFailure {}
