import 'package:flutter/material.dart';

class User {
  int userId;
  String email, password, userName;
  String refreshToken, accessToken;
  User(
      {this.userId,
      this.email,
      this.password,
      this.userName,
      this.accessToken,
      this.refreshToken});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      email: json['email'],
      userName: json['name'],
    );
  }
  setToken(String accessToken, String refreshToken) {
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
  }
}
