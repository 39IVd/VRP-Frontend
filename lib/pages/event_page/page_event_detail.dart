import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vrp_frontend/components/components.dart';
import 'package:vrp_frontend/models/models.dart';
import 'package:vrp_frontend/utils/utils.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/keys.dart';
import '../../models/models.dart';
import 'package:vrp_frontend/dummylist.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:vrp_frontend/routes.dart';

class EventDetailPage extends StatefulWidget {
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  int currentSceneIndex = 0;
  int nextSceneIndex = 0;
  List<Scene> sceneList = List();
  List<String> sceneNameList = List(), sceneCreatedAtList = List();
  Scene _selectedScene;

  @override
  void initState() {
    sceneList = dummySceneList;
    sceneNameList = sceneList.map((Scene e) => e.sceneName).toList();
    sceneCreatedAtList = sceneList.map((e) => e.createdAt).toList();
    _selectedScene = sceneList[currentSceneIndex];
    super.initState();
  }

  Future getTeamLeader() async {
    // TODO: 사건의 teamLeader id로 팀장 이름 찾기
    final http.Response response = await http.post(
      '',
      headers: <String, String>{
        'Authorization': authorization,
      },
      // body: jsonEncode(<String, String>{
      //   'email': email,
      //   'password': password,
      //   'userName': userName
      // }),
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    if (response.statusCode == 200) {
    } else {
      throw Exception();
    }
  }

  Future<User> getEventDetail() async {
    final http.Response response = await http.get(
      // TODO:
      'https://jsonplaceholder.typicode.com/albums/1',
      headers: <String, String>{
        'Authorization': authorization,
      },
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json['data'];
      String eventId = data['eventId'];
      String createdAt = data['createdAt'];
      String eventStartedAt = data['eventStartedAt'];
      String eventStatus = data['eventStatus'];
      String eventName = data['eventName'];
      String teamLeader = data['teamLeader'];
      List scenes = data['scenes']['scenes'];
      List teamMembers = data['teamMembers'];
    } else if (response.statusCode == 401) {
      // 허가되지 않은 유저 / 입력값 실패 / 권한 없는 유저 / 없는 팀
      // TODO:
      String message = json['message'];
      print(message);
      throw Exception(message);
    } else {
      throw Exception('왜인지 모르겠지만 실패함');
    }
  }

  Future<List<Scene>> getSceneList() async {
    List<Scene> sceneList = List();
    final http.Response response = await http.get(
      '',
      // TODO: http://localhost:8081/scenes?event_id=24
      headers: <String, String>{
        'Authorization': authorization,
      },
    );
    Map<String, Object> json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // TODO:
      // List sceneList = json['data']['scenes'];
      return sceneList;
    } else if (response.statusCode == 401) {
      // 허가되지 않은 유저
      String message = json['message'];
      throw Exception(message);
    } else if (response.statusCode == 400) {
      // 존재하지 않는 팀
      String message = json['message'];
      throw Exception(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context).settings.arguments;
    String teamMemberName = '';
    event.teamMembers.map((e) => e.userName).toList().forEach((element) {
      teamMemberName += element + '  ';
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              NavigationBar(),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: marginBottom12,
                  child: Text(
                    "Event Detail",
                    style: headlineTextStyle,
                  ),
                ),
              ),
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
              Align(
                alignment: Alignment.center,
                child: TextHeadlineSecondary(
                    text: '사건 발생일 : ${event.eventStartedAt}'),
              ),
              Align(
                alignment: Alignment.center,
                child: TextHeadlineSecondary(text: '상태 : ${event.eventStatus}'),
              ),
              Container(height: 10),
              dividerSmall,
              Container(height: 20),
              Align(
                alignment: Alignment.center,
                child: TextHeadlineSecondary(text: '< 현장 리스트 >'),
              ),
              sceneList.isEmpty
                  ? Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Text(
                          '등록된 현장이 없습니다.',
                          style: headlineTextStyle,
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        HorizontalCardPager(
                          items: getSceneImageItems(sceneList),
                          onSelectedItem: (page) {
                            print(page);
                          },
                          initialPage: currentSceneIndex,
                          onPageChanged: (page) {
                            setState(() {
                              if ((page - currentSceneIndex.toDouble()).abs() >=
                                  1) {
                                currentSceneIndex = nextSceneIndex;
                              } else if (page > currentSceneIndex) {
                                nextSceneIndex = currentSceneIndex + 1;
                              } else if (page < currentSceneIndex) {
                                nextSceneIndex = currentSceneIndex - 1;
                              }
                              _selectedScene = sceneList[currentSceneIndex];
                            });
                          },
                        ),
                        TextHeadlineSecondary(
                            text: '현장명 : ${sceneNameList[currentSceneIndex]}'),
                        TextBody(
                            text:
                                '등록일 : ${sceneCreatedAtList[currentSceneIndex]}'),
                        SceneDetailButton(
                          // 자세히 보기
                          onPressed: () => Navigator.pushNamed(
                              context, Routes.sceneDetail,
                              arguments: _selectedScene),
                        ),
                      ],
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TagWrapper(tags: [
                      EventOptionButton(
                        tag: "새 현장 등록",
                        event: event,
                      ),
                    ]),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TagWrapper(tags: [
                      EventOptionButton(
                        tag: "참여자 수정",
                        event: event,
                      ),
                      EventOptionButton(
                        tag: "사건 수정",
                        event: event,
                      ),
                      EventOptionButton(
                        tag: "사건 삭제",
                        event: event,
                      )
                    ]),
                  ),
                ],
              ),
              ...authorSection(
                  imageUrl: "assets/images/avatar_default.png",
                  name: "팀장 : ${event.teamLeader}",
                  bio: "참여자 : $teamMemberName"),
              event.createdAt != null
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child:
                          TextBodySecondary(text: '생성일 : ${event.createdAt}'),
                    )
                  : Container(),
              divider,
              Footer(),
            ],
          ),
        ),
      ),
    );
  }

  List<CardItem> getSceneImageItems(List<Scene> sceneList) {
    List<CardItem> items = [];
    for (int i = 0; i < sceneList.length; i++) {
      String fileId = sceneList[i].fileId;
      items.add(ImageCarditem(
        image: Image.asset(
          'images/scenes/${fileId}.jpg',
          fit: BoxFit.cover,
        ),
      ));
    }
    return items;
  }
}
