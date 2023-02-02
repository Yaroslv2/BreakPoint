import 'package:brandpoint/application/storage.dart';
import 'package:brandpoint/models/user.dart';
//import 'package:dio/dio.dart';

class AutheficationService {
  //final Dio _dio = Dio();
  final Storage _storage = Storage();

  Future<User?> registration(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 4)); // for now

    // send to server and get token
    final response = "newId";

    // save token
    _storage.putTokenInStorage(response);
    _storage.saveUser(email, name);

    return User(response, name, email);
  }

  Future<User?> signInWithPasswordAndEmail(
      String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // for now

    // send to server and get info about user
    final response = "NewId";

    // save token
    _storage.putTokenInStorage(response);

    return User(response, "TestName", email);
  }

  Future<User?> signInWithToken() async {
    // get token into storage
    final token = await _storage.getTokenInStorage();

    // send token on server and get info about User
    final user = await _storage.getUser();
    return User(token as String, user['name'], user["email"] as String);
  }

  void signOut() {
    _storage.deleteToken();
  }
}
