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

  Future<void> saveUser(String _email, String _name) async {
    final storage = await SharedPreferences.getInstance();
    storage.setString("email", _email);
    storage.setString("name", _name);
  }

  Future<Map<String, String?>> getUser() async {
    final storage = await SharedPreferences.getInstance();
    Map<String, String?> result = {
      "email": storage.getString("email"),
      "name": storage.getString("name"),
    };
    return result;
  }
}
