import 'package:flutter/material.dart';
import 'package:vrp_frontend/components/components.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vrp_frontend/utils/utils.dart';
import '../../models/models.dart';
import 'dart:html';
import 'dart:typed_data';
import 'package:vrp_frontend/utils/utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateScenePage extends StatefulWidget {
  CreateScenePage({Key key}) : super(key: key);

  @override
  _CreateScenePageState createState() => _CreateScenePageState();
}

class _CreateScenePageState extends State<CreateScenePage> {
  String _sceneName = '', _address1 = '', _address2 = '', _zip = '';
  int _eventId;
  Uint8List uploadedImage;
  String pickedImage;
  String _sceneFileName = '', _evidenceFileName = '';
  int _sceneFileSize = 0, _evidenceFileSize = 0;
  PlatformFile _pickedSceneFile, _pickedEvidenceFile;
  String _accessToken;
  @override
  void initState() {
    super.initState();
    (() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _accessToken = prefs.getString('accessToken');
        _eventId = prefs.getInt('eventId');
      });
      print("accessToken in initstate : $_accessToken");
    })();
  }

  Future<bool> registerScene(BuildContext context) async {
    final http.Response response = await http.post(
      // TODO: REST API 주소
      'http://localhost:8081/scenes',
      headers: <String, String>{
        'Authorization': _accessToken,
      },
      body: jsonEncode(<String, Object>{
        "sceneName": _sceneName,
        "address1": _address1,
        "address2": _address2,
        "zip": _zip,
        "eventId": _eventId,
      }),
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    if (response.statusCode == 201) {
      var sceneId = json['data']['sceneId'];
      print("sceneId : $sceneId");
      return true;
    } else {
      String message = json['message'];
      showFlushBar(context, message);
      return false;
    }
  }

  Future<PlatformFile> pickImageFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    PlatformFile pickedFile;
    if (result != null) {
      pickedFile = result.files.first;
    } else {
      print("user canceled");
    }
    return pickedFile;
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
    final uploadSceneFileButton = Container(
      alignment: Alignment.centerLeft,
      child: RawMaterialButton(
        onPressed: () async {
          _pickedSceneFile = await pickImageFile();
          if (_pickedSceneFile != null) {
            setState(() {
              _sceneFileName = _pickedSceneFile.name;
              _sceneFileSize = _pickedSceneFile.size;
              print("fileSize : $_sceneFileSize");
            });
          }
        },
        child: Text(
          '현장 사진 업로드',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        fillColor: Colors.grey[300],
        padding: EdgeInsets.symmetric(horizontal: 16),
        elevation: 0,
        hoverElevation: 0,
        hoverColor: Colors.grey[400],
        highlightElevation: 0,
        focusElevation: 0,
      ),
    );
    final uploadEventFileButton = Container(
      alignment: Alignment.centerLeft,
      child: RawMaterialButton(
        onPressed: () async {
          _pickedEvidenceFile = await pickImageFile();
          if (_pickedEvidenceFile != null) {
            setState(() {
              _evidenceFileName = _pickedEvidenceFile.name;
              _evidenceFileSize = _pickedEvidenceFile.size;
              print("fileSize : $_evidenceFileSize");
            });
          }
        },
        child: Text(
          '증거물 사진 업로드',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        fillColor: Colors.grey[300],
        padding: EdgeInsets.symmetric(horizontal: 16),
        elevation: 0,
        hoverElevation: 0,
        hoverColor: Colors.grey[400],
        highlightElevation: 0,
        focusElevation: 0,
      ),
    );

    final registerButton = Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: RaisedButton(
        onPressed: () async {
          if (_sceneName == '' ||
              _address1 == '' ||
              _address2 == '' ||
              _zip == '') {
            showFlushBar(context, "올바른 형식을 입력해주세요.");
          } else if (_pickedSceneFile == null || _pickedEvidenceFile == null) {
            showFlushBar(context, "사진을 등록해주세요.");
          } else {
            bool success = await registerScene(context);
            if (success) {
              Navigator.pop(context);
              showFlushBar(context, "새 현장이 등록되었습니다.");
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
                          "사건 현장 등록",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                        Container(height: 20),
                        dividerSmall,
                        Container(height: 20),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: marginBottom12,
                            child: Text(
                              event.eventName,
                              style: headlineTextStyle,
                            ),
                          ),
                        ),
                        SizedBox(height: 48.0),
                        sceneNameForm,
                        SizedBox(height: 8.0),
                        address1Form,
                        SizedBox(height: 8.0),
                        address2Form,
                        SizedBox(height: 8.0),
                        zipForm,
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _pickedSceneFile == null
                              ? [uploadSceneFileButton]
                              : [
                                  uploadSceneFileButton,
                                  Container(width: 20),
                                  Text(
                                    '파일명 : ${_sceneFileName}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(width: 10),
                                  Text(
                                    '파일 사이즈 : ${_sceneFileSize}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: _pickedEvidenceFile == null
                              ? [uploadEventFileButton]
                              : [
                                  uploadEventFileButton,
                                  Container(width: 20),
                                  Text(
                                    '파일명 : ${_evidenceFileName}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(width: 10),
                                  Text(
                                    '파일 사이즈 : ${_evidenceFileSize}',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                        ),
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
