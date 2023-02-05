import 'dart:convert';

import 'package:brandpoint/application/auth/services/response.dart';
import 'package:brandpoint/application/storage.dart';
import 'package:brandpoint/constants.dart';
import 'package:brandpoint/models/user.dart';
import 'package:dio/dio.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AutheficationService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://192.168.0.19:5000",
    contentType: "application/json",
  ));
  final Storage _storage = Storage();

  Future<MyResponse> registration(
      String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 4)); // for now

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
    await Future.delayed(const Duration(seconds: 2)); // for now

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

  Future<MyResponse?> signInWithToken() async {
    // get token into storage
    final token = await _storage.getTokenInStorage();

    if (token != null) {
      if (!Jwt.isExpired(token)) {
        return null;
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
            if (response.data["error"] != null) {
              return null;
            } else {
              return MyResponse(response.data, response.statusCode);
            }
          } else {
            return null;
          }
        } catch (error) {
          return null;
        }
      }
    } else {
      return null;
    }
  }

  void signOut() {
    _storage.deleteToken();
  }
}
