import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String? customerId;
  final String? name;
  final String? email;

  LoginModel({
    this.customerId,
    this.name,
    this.email,
  });

  LoginModel copyWith({
    String? customerId,
    String? name,
    String? email,
  }) =>
      LoginModel(
        customerId: customerId ?? this.customerId,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        customerId: json["customerId"],
        name: json["name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "name": name,
        "email": email,
      };
}
