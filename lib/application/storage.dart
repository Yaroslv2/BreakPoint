import 'package:brandpoint/models/user.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final _key = "token";

  Future<bool> isHaveToken() async {
    final storage = await SharedPreferences.getInstance();
    final result = storage.get(_key);
    if (result == null) storage.clear();
    return (result == null) || (result == "") ? false : true;
  }

  Future<String?> getTokenInStorage() async {
    final storage = await SharedPreferences.getInstance();
    final result = storage.getString(_key);
    return result;
  }

  Future<void> putTokenInStorage(String token) async {
    final storage = await SharedPreferences.getInstance();
    storage.setString(_key, token);
  }

  Future<void> deleteToken() async {
    final storage = await SharedPreferences.getInstance();
    storage.clear();
    print("token deleted");
  }

  Future<User> getUser() async {
    final storage = await SharedPreferences.getInstance();
    final token = storage.getString(_key);

    final payload = Jwt.parseJwt(token!);

    return User(payload["name"], payload["mail"]);
  }
}
