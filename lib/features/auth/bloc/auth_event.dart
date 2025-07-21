import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {
  const AuthCheckRequested();
}

class AuthSignInRequested extends AuthEvent {
  const AuthSignInRequested();
}

class AuthSignUpRequested extends AuthEvent {
  const AuthSignUpRequested();
}

class AuthSignOutRequested extends AuthEvent {
  const AuthSignOutRequested();
}
