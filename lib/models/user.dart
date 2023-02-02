// class User {
//   final String username;
//   final String email;
//   final String id;

//   User(this.username, this.email, this.id);

//   User.fromJson(Map<String, dynamic> json)
//       : username = json["username"],
//         email = json["email"],
//         id = json["id"];

//   Map<String, dynamic> toJson() {
//     return {'username': username, 'email': email, 'id': id};
//   }
// }

// class UserResponse extends MyResponse {
//   final List<User> results;
//   final String error;
//   int? statusCode;

//   UserResponse(this.results, this.error, this.statusCode);

//   UserResponse.fromJson(List<dynamic> json, statusCode)
//       : results = json.map((e) => User.fromJson(e)).toList(),
//         error = "";

//   UserResponse.withError(String errorValue, statusCode)
//       : results = [],
//         error = errorValue;
// }

// class MyResponse {
//   dynamic body;
//   String? error;
//   int? statusCode;

//   MyResponse();

//   MyResponse.withError(String errorValue);
// }

class User {
  const User(this.id, this.name, this.email);

  final String id;
  final String? name;
  final String email;
}
