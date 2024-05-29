part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthSignedUp extends AuthEvent {
  final String email;
  final String password;

  const AuthSignedUp({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthSignedIn extends AuthEvent {
  final String email;
  final String password;

  const AuthSignedIn({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class AuthSignedOut extends AuthEvent {}
