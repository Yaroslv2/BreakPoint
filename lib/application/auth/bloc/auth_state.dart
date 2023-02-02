part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthNotAutheficated extends AuthState {}

class AuthAutheficated extends AuthState {
  final User user;

  AuthAutheficated({required this.user});

  @override
  List<Object> get props => [user];
}

class AuthLogOut extends AuthState {}

class AuthFailure extends AuthState {}
