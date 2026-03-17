part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class CreateAccount extends AuthEvent {
  final String email;
  final String password;
  final String fullName;
  final String phoneNumber;

  const CreateAccount({
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNumber,
  });

  @override
  List<Object> get props => [email, password, fullName, phoneNumber];
}

class Login extends AuthEvent {
  final String email;
  final String password;

  const Login({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class Logout extends AuthEvent {
  @override
  List<Object> get props => [];
}

class CheckAuthStatus extends AuthEvent {
  @override
  List<Object> get props => [];
}
