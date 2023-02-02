part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppLoad extends AuthEvent {}

class UserLogIn extends AuthEvent {
  String email;
  String password;

  UserLogIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class UserRegistration extends AuthEvent {
  String name;
  String email;
  String password;

  UserRegistration(
      {required this.name, required this.email, required this.password});

  @override
  List<Object> get props => [name, email, password];
}

class UserLogOut extends AuthEvent {}
