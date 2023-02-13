import 'package:bloc/bloc.dart';
import 'package:brandpoint/application/auth/services/authefication_service.dart';
import 'package:brandpoint/application/storage.dart';
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
      if (await _storage.isHaveToken()) {
        final response = await _autheficationService.signInWithToken();
        if (response) {
          print("true response");
          emit(AuthAutheficated());
        } else {
          print("false response");
          emit(AuthNotAutheficated());
        }
      } else {
        print("Havent token");
        emit(AuthNotAutheficated());
      }
    } catch (error) {
      print("error");
      emit(AuthNotAutheficated());
    }
  }

  Future _userLogIn(UserLogIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    print("_userLogIn");
    try {
      final response = await _autheficationService.signInWithPasswordAndEmail(
          event.email, event.password);
      if (response.statusCode == 200) {
        emit(AuthAutheficated());
      } else {
        emit(AuthFailure(message: response.error));
      }
    } catch (error) {
      emit(AuthFailure(message: "$error"));
    }
  }

  Future _userRegistration(
      UserRegistration event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final response = await _autheficationService.registration(
          event.name, event.email, event.password);
      if (response.statusCode == 200) {
        if (response.body["error"] != null) {
          emit(AuthFailure(message: "${response.body["error"]}"));
        } else {
          emit(AuthAutheficated());
        }
      } else {
        emit(const AuthFailure(message: "Something going wrong..."));
      }
    } catch (error) {
      emit(AuthFailure(message: "$error"));
    }
  }

  Future _userLogOut(UserLogOut event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      _autheficationService.signOut();
      emit(AuthNotAutheficated());
    } catch (error) {
      emit(AuthFailure(message: "$error"));
    }
  }
}
