import 'package:flutter/material.dart';
import 'package:vrp_frontend/components/components.dart';
import 'package:vrp_frontend/utils/utils.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/keys.dart';
import '../models/models.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String email = '', userName = '';
  String createdAt = '';
  Future<User> getMyInfo() async {
    final http.Response response = await http.get(
        // TODO:
        'https://jsonplaceholder.typicode.com/albums/1');
    Map<String, dynamic> json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      String email = json['data']['email'];
      String userName = json['data']['userName'];
      int userId = json['data']['userId'];
      return User(userId: userId, email: email, userName: userName);
    } else if (response.statusCode == 401) {
      // 허가되지 않은 유저
      // TODO:
      String message = json['message'];
      print(message);
      throw Exception(message);
    } else if (response.statusCode == 400) {
      // 입력값 실패 / 없는 유저
      // TODO:
      String message = json['message'];
      print(message);
      throw Exception(message);
    } else {
      throw Exception('왜인지 모르겠지만 실패함');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: <Widget>[
                  NavigationBar(),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom12,
                      child: Text("MY PAGE", style: headlineTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom24,
                      child: Text("My Information",
                          style: headlineSecondaryTextStyle),
                    ),
                  ),
                  dividerSmall,
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: marginBottom24,
                      child: Text("Name : $userName",
                          style: headlineSecondaryTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: marginBottom24,
                      child: Text("Email : $email",
                          style: headlineSecondaryTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: marginBottom24,
                      child: Text("Join Date : $createdAt",
                          style: headlineSecondaryTextStyle),
                    ),
                  ),
                  divider,
                  Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
