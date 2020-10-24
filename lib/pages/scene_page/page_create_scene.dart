import 'package:flutter/material.dart';
import 'package:vrp_frontend/components/components.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vrp_frontend/utils/utils.dart';
import '../../models/models.dart';

class CreateScenePage extends StatefulWidget {
  CreateScenePage({Key key}) : super(key: key);

  @override
  _CreateScenePageState createState() => _CreateScenePageState();
}

class _CreateScenePageState extends State<CreateScenePage> {
  String _sceneName = '', _address1 = '', _address2 = '', _zip = '';
  int _eventId;
  Future<User> registerScene(String sceneName, String address1, String address2,
      String zip, int eventId) async {
    final http.Response response = await http.post(
      // TODO: REST API 주소
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Authorization': authorization,
      },
      body: jsonEncode(<String, Object>{
        "sceneName": sceneName,
        "address1": address1,
        "address2": address2,
        "zip": zip,
        "eventId": eventId,
      }),
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    String message = json['message'];
    if (response.statusCode == 201) {
      String sceneId = json['data']['sceneId'];
    } else if (response.statusCode == 401) {
      // 허가되지 않은 유저
      // TODO:
      throw Exception(message);
    } else if (response.statusCode == 400) {
      // 입력값 실패 / 존재하지 않는 사건 / 사건 수정 권한 없음 / 사건 내 현장 이름 중복
      // TODO:
      throw Exception(message);
    } else {
      throw Exception('왜인지 모르겠지만 실패함');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context).settings.arguments;
    _eventId = event.eventId;
    final sceneNameForm = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: '현장명\t\t\t\t\t\t예) 피해자의 집 거실',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onChanged: (String str) {
        setState(() {
          _sceneName = str.trim();
        });
      },
    );
    final address1Form = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: '주소 1\t\t\t\t\t\t예) 서울특별시 광진구 자양동',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onChanged: (String str) {
        setState(() {
          _address1 = str.trim();
        });
      },
    );
    final address2Form = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: '주소 2\t\t\t\t\t\t예) 미래아파트 101동 202호',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onChanged: (String str) {
        setState(() {
          _address2 = str.trim();
        });
      },
    );
    final zipForm = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: '우편번호\t\t\t\t\t예) 05011',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
      onChanged: (String str) {
        setState(() {
          _zip = str.trim();
        });
      },
    );
    final registerButton = Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: RaisedButton(
        onPressed: () {
          if (_sceneName == '' ||
              _address1 == '' ||
              _address2 == '' ||
              _zip == '') {
            showFlushBar(context, "올바른 형식을 입력해주세요.");
          } else {
            Navigator.pop(context);
            showFlushBar(context, "새 현장이 등록되었습니다.");
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
                          "현장 등록",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        SizedBox(height: 48.0),
                        sceneNameForm,
                        SizedBox(height: 8.0),
                        address1Form,
                        SizedBox(height: 8.0),
                        address2Form,
                        SizedBox(height: 8.0),
                        zipForm,
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
