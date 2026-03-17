part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();
}

final class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

final class Authenticated extends AuthState {
  const Authenticated(this.user);

  final AuthDomain user;

  @override
  List<Object> get props => [user];
}

final class UnAuthenticated extends AuthState {
  @override
  List<Object> get props => [];
}

final class AuthError extends AuthState {
  const AuthError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
