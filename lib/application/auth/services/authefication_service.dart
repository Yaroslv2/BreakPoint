import 'dart:convert';

import 'package:brandpoint/models/response.dart';
import 'package:brandpoint/application/storage.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AutheficationService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://vad.pythonanywhere.com",
    contentType: "application/json",
  ));
  final Storage _storage = Storage();

  Future<MyResponse> registration(
      String name, String email, String password) async {
    // send to server and get token
    var params = {
      "mail": email,
      "psw": password,
      "name": name,
    };

    var response;
    try {
      response = await _dio.post(
        "/registr",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
        ),
        data: json.encode(params),
      );
      if (response.statusCode == 200) {
        if (response.data["error"] != null) {
          return MyResponse.withError(response.data, response.statusCode);
        } else {
          _storage.putTokenInStorage(response.data["access_token"]);
          return MyResponse(response.data, response.statusCode);
        }
      } else {
        return MyResponse.withError(response.data, response.statusCode);
      }
    } catch (error) {
      return MyResponse.withError("$error", 0);
    }
  }

  Future<MyResponse> signInWithPasswordAndEmail(
      String email, String password) async {
    var params = {
      "mail": email,
      "psw": password,
    };

    var response;

    try {
      response = await _dio.post(
        "/login",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
        ),
        data: json.encode(params),
      );
      print(response);
      if (response.statusCode == 200) {
        if (response.data["error"] != null) {
          return MyResponse.withError(response.data["error"], 0);
        } else {
          _storage.putTokenInStorage(response.data["access_token"]);
          return MyResponse(response.data, response.statusCode);
        }
      } else {
        return MyResponse.withError(response.data, response.statusCode);
      }
    } catch (error) {
      return MyResponse.withError("$error", 0);
    }
  }

  Future<bool> signInWithToken() async {
    final token = await _storage.getTokenInStorage();
    print(token);
    if (token != null) {
      if (Jwt.isExpired(token)) {
        return false;
      } else {
        var params = {"access_token": token};
        var response;
        try {
          response = await _dio.post(
            "/does_exists",
            options: Options(
              headers: {
                "Content-Type": "application/json",
                "Accept": "application/json"
              },
            ),
            data: json.encode(params),
          );
          if (response.statusCode == 200) {
            print("Response: $response");
            if (response.data["error"] != null) {
              return false;
            } else {
              return true;
            }
          } else {
            return false;
          }
        } catch (error) {
          return false;
        }
      }
    } else {
      return false;
    }
  }

  void signOut() {
    _storage.deleteToken();
  }
}
