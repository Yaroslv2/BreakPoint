import 'dart:convert';

import 'package:brandpoint/application/storage.dart';
import 'package:brandpoint/models/cart_item.dart';
import 'package:brandpoint/models/response.dart';
import 'package:dio/dio.dart';

class CartService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://vad.pythonanywhere.com",
      contentType: "application/json",
    ),
  );
  final _storage = Storage();

  Future<MyResponse> getCart() async {
    final token = await _storage.getTokenInStorage();

    var params = {
      "access_token": token,
      "item_counter": cartItemCounter,
    };

    var response;
    try {
      response = await _dio.post(
        "/show_cart",
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
          return MyResponse.withError(response.data["error"], 0);
        } else {
          cartItemCounter += response.data["item_counter"] as int;
          var itemList = List<CartItem>.from(
              response.data["items"].map((e) => CartItem.fromJson(e)));
          return MyResponse(itemList, response.statusCode);
        }
      } else {
        return MyResponse.withError(
            response.data["error"], response.statusCode);
      }
    } catch (e) {
      return MyResponse.withError(e.toString(), 0);
    }
  }
}
