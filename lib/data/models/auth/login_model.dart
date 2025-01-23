import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String? customerId;
  final String? name;
  final String? email;
  final String? profileImage;

  LoginModel({
    this.customerId,
    this.name,
    this.email,
    this.profileImage,
  });

  LoginModel copyWith({
    String? customerId,
    String? name,
    String? email,
    String? profileImage,
  }) =>
      LoginModel(
        customerId: customerId ?? this.customerId,
        name: name ?? this.name,
        email: email ?? this.email,
        profileImage: email ?? this.profileImage,
      );

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        customerId: json["customerId"],
        name: json["name"],
        email: json["email"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "name": name,
        "email": email,
        "profileImage": profileImage,
      };
}
