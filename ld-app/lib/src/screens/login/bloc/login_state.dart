part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState(
      {this.status = FormzSubmissionStatus.initial,
      this.phone = const Phone.pure(),
      this.password = const Password.pure(),
      this.isValid = false,
      this.message});

  final FormzSubmissionStatus status;
  final Phone phone;
  final Password password;
  final bool isValid;
  final String? message;

  LoginState copyWith(
      {FormzSubmissionStatus? status,
      Phone? phone,
      Password? password,
      bool? isValid,
      String? message}) {
    return LoginState(
        status: status ?? this.status,
        phone: phone ?? this.phone,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
        message: message ?? this.message);
  }

  @override
  List<Object> get props => [status, phone, password];
}
