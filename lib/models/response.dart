class MyResponse {
  final dynamic body;
  final String error;
  int statusCode;

  MyResponse(this.body, this.statusCode) : error = "";

  MyResponse.withError(String errorValue, this.statusCode)
      : body = null,
        error = errorValue;
}
