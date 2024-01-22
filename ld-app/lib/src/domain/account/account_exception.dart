part of 'account.dart';

sealed class AccountException {}

class AccountDataAccessException extends AccountException {}

class AccountNotFoundException extends AccountException {}

class AccountDomainException extends AccountException {}

class AccountCreatedException extends AccountException {}

class AccountUpdatedException extends AccountException {}