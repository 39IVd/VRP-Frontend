import 'package:flutter/material.dart';
import 'package:vrp_frontend/components/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final loginButton = Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: RaisedButton(
        onPressed: () {
          (() async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            setState(() {
              prefs.setBool('isLogin', true);
            });
            print("login");
            print("isLogin : ${prefs.getBool('isLogin')}");
          })();
          Navigator.popUntil(
              context, ModalRoute.withName(Navigator.defaultRouteName));
        },
        padding: EdgeInsets.all(12),
        color: Colors.grey,
        child: Text('로그인',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
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
                      email,
                      SizedBox(height: 8.0),
                      password,
                      SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value;
                                  });
                                },
                              ),
                              Text("Remember Me")
                            ],
                          ),
                          forgotLabel,
                        ],
                      ),
                      SizedBox(height: 18.0),
                      loginButton,
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
