import 'package:flutter/material.dart';
import 'package:vrp_frontend/components/components.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vrp_frontend/utils/utils.dart';
import '../../models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SceneDetailPage extends StatefulWidget {
  final int eventId, sceneId;
  SceneDetailPage({Key key, this.eventId, this.sceneId}) : super(key: key);
  @override
  _SceneDetailPageState createState() => _SceneDetailPageState();
}

class _SceneDetailPageState extends State<SceneDetailPage> {
  int _eventId, _sceneId;
  String _accessToken;
  Scene scene;
  @override
  void initState() {
    super.initState();
    (() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _accessToken = prefs.getString('accessToken');
      scene = await getSceneDetail();
    })();
  }

  Future<Scene> getSceneDetail() async {
    final http.Response response = await http.get(
      'http://localhost:8081/scenes/${widget.sceneId}?event_id=${widget.eventId}',
      headers: <String, String>{
        'Authorization': _accessToken,
      },
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Scene scene = Scene.fromJson(json['data']);
      return scene;
    } else {
      String message = json['message'];
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final Scene scene = ModalRoute.of(context).settings.arguments;
    // final List eventAndScene = ModalRoute.of(context).settings.arguments;
    // _eventId = eventAndScene[0];
    // _sceneId = eventAndScene[1];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: scene == null
                ? [
                    NavigationBar(),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: marginBottom12,
                        child: Text(
                          "Scene Detail",
                          style: headlineTextStyle,
                        ),
                      ),
                    ),
                    divider,
                    Footer(),
                  ]
                : [
                    NavigationBar(),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: marginBottom12,
                        child: Text(
                          "Scene Detail",
                          style: headlineTextStyle,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: marginBottom12,
                        child: Text(
                          scene.sceneName,
                          style: headlineTextStyle,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 500,
                      child: Image.asset(
                        // TODO:
                        'assets/images/scenes/0.jpg',
                        // 'assets/images/scenes/${scene.fileId}.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(height: 30),
                    // TextHeadlineSecondary(text: '주소 1 : ${scene.address1}'),
                    // TextHeadlineSecondary(text: '주소 2 : ${scene.address2}'),
                    TextBody(text: '등록일 : ${scene.createdAt}'),
                    Container(height: 30),
                    divider,
                    Footer(),
                  ],
          ),
        ),
      ),
    );
  }
}
