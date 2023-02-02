import 'package:bloc/bloc.dart';
import 'package:brandpoint/application/auth/services/authefication_service.dart';
import 'package:brandpoint/application/storage.dart';
import 'package:brandpoint/models/user.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AutheficationService _autheficationService;
  final Storage _storage = Storage();

  AuthBloc(AutheficationService autheficationService)
      : _autheficationService = autheficationService,
        super(AuthInitial()) {
    on<AppLoad>(_appLoad);
    on<UserLogIn>(_userLogIn);
    on<UserRegistration>(_userRegistration);
    on<UserLogOut>(_userLogOut);
  }

  Future _appLoad(AppLoad event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    print("_appLoad");

    try {
      Future.delayed(const Duration(seconds: 4));
      if (await _storage.isHaveToken()) {
        final user = await _autheficationService.signInWithToken();
        if (user != null) {
          emit(AuthAutheficated(user: user as User));
        } else {
          emit(AuthNotAutheficated());
        }
      } else {
        emit(AuthNotAutheficated());
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Future _userLogIn(UserLogIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _autheficationService.signInWithPasswordAndEmail(
          event.email, event.password);
      if (user != null) {
        emit(AuthAutheficated(user: user));
      } else {
        emit(AuthNotAutheficated());
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Future _userRegistration(
      UserRegistration event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _autheficationService.registration(
          event.name, event.email, event.password);
      if (user != null) {
        emit(AuthAutheficated(user: user));
      } else {
        (AuthNotAutheficated());
      }
    } catch (e) {
      print("error: $e");
    }
  }

  Future _userLogOut(UserLogOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      _autheficationService.signOut();
      emit(AuthNotAutheficated());
    } catch (e) {
      print("error: $e");
    }
  }
}
