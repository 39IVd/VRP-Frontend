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
  String _email = '', _password = '', _userName = '';
  User user;
  Future<bool> postSignUp(BuildContext context, String email, String password,
      String userName) async {
    final http.Response response = await http.post(
      'http://localhost:8082/users/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=utf-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'userName': userName,
        'password': password,
      }),
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    String message = json['message'];
    if (response.statusCode == 201) {
      int id = json['data']['userId'];
      print("id : $id");
      user = User(id: id, email: email, password: password, userName: userName);
      return true;
    } else if (response.statusCode == 400) {
      // 입력값 실패 or 중복된 이메일
      // TODO:
      showFlushBar(context, message);
      return false;
    } else {
      print(message);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userNameTextForm = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'User Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onChanged: (String str) {
        setState(() {
          _userName = str.trim();
        });
      },
    );
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
          _password = str.trim();
        });
      },
    );

    final joinButton = Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: RaisedButton(
        onPressed: () async {
          // TODO: 회원 정보 등록
          if (!checkEmailValid(_email)) {
            showFlushBar(context, "이메일이 형식에 맞지 않습니다.");
          } else if (_password == '') {
            showFlushBar(context, "올바른 비밀번호를 입력해주세요.");
          } else {
            bool success =
                await postSignUp(context, _email, _password, _userName);
            if (success) {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
              showFlushBar(context, "회원가입이 완료되었습니다.");
            }
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
                      userNameTextForm,
                      SizedBox(height: 8.0),
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
