import 'dart:convert';

import 'package:brandpoint/models/product_list.dart';
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
      "item_counter": itemCounter,
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
      if (response.statusCode == 200) {
        if (response.data["error"] != null) {
          print("error response");
          return MyResponse.withError(response.data["error"], 0);
        } else {
          itemCounter += response.data["item_counter"] as int;
          List<Product>? itemList = List<Product>.from(
              response.data["items"].map((i) => Product.fromJson(i)));
          if (itemList.isEmpty) {
            hasMore = false;
          }
          productList.addAll(itemList);

          return MyResponse(productList, response.statusCode);
        }
      } else {
        print("error statusCode");
        return MyResponse.withError("errorValue", response.statusCode);
      }
    } catch (e) {
      print("$e");
      return MyResponse.withError(e.toString(), 0);
    }
  }
}
