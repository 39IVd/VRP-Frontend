import 'package:flutter/material.dart';

class User {
  String id;
  String email, password, userName;
  String refreshToken, accessToken;
  User(
      {this.id,
      this.email,
      this.password,
      this.userName,
      this.accessToken,
      this.refreshToken});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      password: json['password'],
      userName: json['name'],
    );
  }
  setToken(String accessToken, String refreshToken) {
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
  }
}
