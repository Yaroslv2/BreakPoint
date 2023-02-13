import 'dart:convert';

import 'package:brandpoint/application/home/product_list.dart';
import 'package:brandpoint/models/response.dart';
import 'package:dio/dio.dart';

class HomeService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://vad.pythonanywhere.com",
    contentType: "application/json",
  ));

  Future<MyResponse> getProductList(String request) async {
    var params = {
      "request_string": request,
      "item_counter": 0,
    };
    var response;
    try {
      response = await _dio.post(
        "/search",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
          },
        ),
        data: json.encode(params),
      );
      //print(response.data);
      if (response.statusCode == 200) {
        if (response.data["error"] != null) {
          print("error response");
          return MyResponse.withError(response.data["error"], 0);
        } else {
          itemCounter += response.data["item_counter"] as int;
          final itemList =
              response.data["items"].map((i) => Product.fromJson(i)).toList();

          return MyResponse(itemList, response.statusCode);
        }
      } else {
        print("error statusCode");
        return MyResponse.withError("errorValue", response.statusCode);
      }
    } catch (e) {
      print("error catch");
      return MyResponse.withError(e.toString(), response.statusCode);
    }
  }
}
