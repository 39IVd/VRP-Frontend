import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrp_frontend/utils/color.dart';
import 'package:vrp_frontend/utils/spacing.dart';
import 'package:vrp_frontend/utils/text.dart';
import 'package:vrp_frontend/utils/typography.dart';
import 'package:vrp_frontend/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  bool isLogin = false;
  Widget loginMenubar() {
    return Wrap(
      children: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, Routes.homePage),
          child: Text(
            "HOME",
            style: buttonTextStyle,
          ),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, Routes.eventList),
          child: Text(
            "EVENTS",
            style: buttonTextStyle,
          ),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, Routes.demo),
          child: Text(
            "DEMO",
            style: buttonTextStyle,
          ),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, Routes.mypage),
          child: Text(
            "MY PAGE",
            style: buttonTextStyle,
          ),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        FlatButton(
          onPressed: () {
            (() async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {
                prefs.setBool('isLogin', false);
                isLogin = false;
              });
              print("logout");
            })();
          },
          child: Text(
            "LOGOUT",
            style: buttonTextStyle,
          ),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      ],
    );
  }

  Widget logoutMenubar() {
    return Wrap(
      children: <Widget>[
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, Routes.homePage),
          child: Text(
            "HOME",
            style: buttonTextStyle,
          ),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, Routes.demo),
          child: Text(
            "DEMO",
            style: buttonTextStyle,
          ),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, Routes.about),
          child: Text(
            "ABOUT",
            style: buttonTextStyle,
          ),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, Routes.login),
          child: Text(
            "LOGIN",
            style: buttonTextStyle,
          ),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        FlatButton(
          onPressed: () => Navigator.pushNamed(context, Routes.join),
          child: Text(
            "JOIN",
            style: buttonTextStyle,
          ),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    (() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        isLogin = prefs.getBool('isLogin') ?? false;
      });
    })();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          child: Row(
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.popUntil(
                    context, ModalRoute.withName(Navigator.defaultRouteName)),
                child: Text("VR Crimescene Project",
                    style: GoogleFonts.montserrat(
                        color: Colors.red[700],
                        fontSize: 30,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w500)),
              ),
              Flexible(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: isLogin ? loginMenubar() : logoutMenubar(),
                ),
              ),
            ],
          ),
        ),
        Container(
            height: 1,
            margin: EdgeInsets.only(bottom: 30),
            color: Color(0xFFEEEEEE)),
      ],
    );
  }
}
