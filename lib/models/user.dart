import 'package:flutter/material.dart';

class User {
  String email, password, name, role;
  User(String email, String password, String name, String role) {
    this.email = email;
    this.password = password;
    this.name = name;
    this.role = role;
  }
}
