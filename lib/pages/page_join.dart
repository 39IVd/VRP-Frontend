import 'package:flutter/material.dart';
import 'package:vrp_frontend/components/components.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/utils.dart';
import '../models/models.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<JoinPage> {
  String _email = '', password = '';

  Future<User> postSignUp(
      String email, String password, String userName) async {
    final http.Response response = await http.post(
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Authorization': authorization,
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'userName': userName
      }),
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    String message = json['message'];
    if (response.statusCode == 201) {
      String id = json['data']['userId'];
      return User(id: id, email: email, password: password, userName: userName);
    } else if (response.statusCode == 400) {
      // 입력값 실패 or 중복된 이메일
      // TODO:
      print(message);
      throw Exception(message);
    } else {
      throw Exception('왜인지 모르겠지만 실패함');
    }
  }

  @override
  Widget build(BuildContext context) {
    final emailTextForm = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onChanged: (String str) {
        setState(() {
          _email = str.trim();
        });
      },
    );

    final passwordTextForm = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onChanged: (String str) {
        setState(() {
          password = str.trim();
        });
      },
    );

    final joinButton = Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: RaisedButton(
        onPressed: () {
          // TODO: 회원 정보 등록
          if (!checkEmailValid(_email)) {
            showFlushBar(context, "이메일이 형식에 맞지 않습니다.");
          } else if (password == '') {
            showFlushBar(context, "올바른 비밀번호를 입력해주세요.");
          } else {
            Navigator.popUntil(
                context, ModalRoute.withName(Navigator.defaultRouteName));
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.grey,
        child: Text('회원가입',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            NavigationBar(),
            Center(
              child: Card(
                elevation: 2.0,
                child: Container(
                  padding: EdgeInsets.all(42),
                  width: MediaQuery.of(context).size.width / 2.5,
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 62.0),
                      Center(
                          child: Text(
                        "VR Crimescene Project",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      SizedBox(height: 48.0),
                      emailTextForm,
                      SizedBox(height: 8.0),
                      passwordTextForm,
                      SizedBox(height: 24.0),
                      joinButton,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
