import 'package:flutter/material.dart';
import 'package:vrp_frontend/components/components.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vrp_frontend/utils/utils.dart';
import '../../models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEventPage> {
  bool isChecked = false;
  String _eventName = '', _eventStartedAt = '', _eventStatus = '';
  String _accessToken;
  @override
  void initState() {
    super.initState();
    print("called create event initstate");
    (() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _accessToken = prefs.getString('accessToken');
        print("accessToken in initstate : $_accessToken");
      });
    })();
  }

  Future<bool> registerEvent(BuildContext context) async {
    print("accessToken in func : $_accessToken");
    final http.Response response = await http.post(
      'http://localhost:8081/events',
      headers: <String, String>{
        'Authorization': _accessToken,
      },
      body: jsonEncode(<String, String>{
        'eventName': _eventName,
        'eventStartedAt': '2012-04-23T18:25:43.511Z',
        'eventStatus': _eventStatus,
      }),
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    String message = json['message'];
    if (response.statusCode == 201) {
      // String _eventId = json['data']['eventId'];
      return true;
    } else if (response.statusCode == 400) {
      // 입력값 실패 or 중복된 사건
      showFlushBar(context, message);
      return false;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventNameForm = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: '사건명\t\t\t\t\t예) 광진구 연쇄살인',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onChanged: (String str) {
        setState(() {
          _eventName = str.trim();
        });
      },
    );
    final eventStartedAtForm = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: '사건 일시\t\t\t\t예) 20201010',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onChanged: (String str) {
        setState(() {
          _eventStartedAt = str.trim();
        });
      },
    );

    final eventStatusForm = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: '진행 상태\t\t\t\t예) 수사중',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onChanged: (String str) {
        setState(() {
          _eventStatus = str.trim();
        });
      },
    );

    final registerButton = Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: RaisedButton(
        onPressed: () async {
          // TODO: 사건 등록
          if (_eventName == '' || _eventStartedAt == '' || _eventStatus == '') {
            showFlushBar(context, "올바른 형식을 입력해주세요.");
          } else {
            bool success = await registerEvent(context);
            if (success) {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
              showFlushBar(context, "새 사건이 등록되었습니다.");
            }
          }
        },
        padding: EdgeInsets.all(12),
        color: Colors.grey,
        child: Text('등록',
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              NavigationBar(),
              Center(
                child: Card(
                  elevation: 2.0,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 62.0),
                        Center(
                            child: Text(
                          "사건 등록",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        SizedBox(height: 48.0),
                        eventNameForm,
                        SizedBox(height: 8.0),
                        eventStartedAtForm,
                        SizedBox(height: 8.0),
                        eventStatusForm,
                        SizedBox(height: 24.0),
                        registerButton,
                      ],
                    ),
                  ),
                ),
              ),
              divider,
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
