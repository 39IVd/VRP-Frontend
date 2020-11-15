import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:vrp_frontend/components/components.dart';
import 'package:vrp_frontend/models/models.dart';
import 'package:vrp_frontend/pages/pages.dart';
import 'package:vrp_frontend/utils/utils.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/models.dart';
import 'package:vrp_frontend/dummylist.dart';
import 'package:horizontal_card_pager/horizontal_card_pager.dart';
import 'package:horizontal_card_pager/card_item.dart';
import 'package:vrp_frontend/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String _accessToken;
  Event event;
  bool _eventLoaded = false;
  int _eventId, _sceneId;

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
      sceneList = await getSceneList(_eventId);
      sceneNameList = sceneList.map((Scene e) => e.sceneName).toList();
      sceneCreatedAtList = sceneList.map((e) => e.createdAt).toList();
      _selectedScene = sceneList[currentSceneIndex];

      // TODO:
      // Event eventDetail = await getEventDetail(_selectedEventId);
      // setState(() {
      //   event = eventDetail;
      //   if (event != null) {
      //     sceneList = eventDetail.scenes;
      //     sceneNameList = sceneList.map((Scene e) => e.sceneName).toList();
      //     sceneCreatedAtList = sceneList.map((e) => e.createdAt).toList();
      //     _selectedScene = sceneList[currentSceneIndex];
      //     _eventLoaded = true;
      //   }
      // });
    })();
  }

  Future<Event> getEventDetail(int eventId) async {
    print("accessToken in func : $_accessToken");
    final http.Response response = await http.get(
      'http://localhost:8081/events/${eventId}',
      headers: <String, String>{
        'Authorization': _accessToken,
      },
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      Event eventDetail = Event.fromJson(json['data']);
      return eventDetail;
    } else if (response.statusCode == 401 || response.statusCode == 400) {
      // 허가되지 않은 유저 / 입력값 실패 / 권한 없는 유저
      String message = json['message'];
      showFlushBar(context, message);
      print(message);
    }
    return null;
  }

  Future<List<Scene>> getSceneList(int eventId) async {
    final http.Response response = await http.get(
      'http://localhost:8081/scenes?event_id=$eventId',
      headers: <String, String>{
        'Authorization': _accessToken,
      },
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      List sceneList = (json['data']['scenes'] as List)
          .map((s) => Scene.fromJson(s))
          .toList();
      return sceneList;
    } else {
      String message = json['message'];
      showFlushBar(context, message);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context).settings.arguments;
    // sceneList = dummySceneList;
    // sceneNameList = sceneList.map((Scene e) => e.sceneName).toList();
    // sceneCreatedAtList = sceneList.map((e) => e.createdAt).toList();
    // _selectedScene = sceneList[currentSceneIndex];
    // _eventLoaded = true;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children:
                // TODO:
                // !_eventLoaded
                //     ? [
                //         NavigationBar(),
                //         Align(
                //           alignment: Alignment.center,
                //           child: Container(
                //             margin: EdgeInsets.fromLTRB(0, 200, 0, 200),
                //             child: CircularProgressIndicator(),
                //           ),
                //         ),
                //         divider,
                //         Footer(),
                //       ]
                //     : event == null
                //         ? [
                //             NavigationBar(),
                //             Align(
                //               alignment: Alignment.center,
                //               child: Container(
                //                 margin: EdgeInsets.fromLTRB(0, 200, 0, 200),
                //                 child: Text("NO EVENTS", style: headlineTextStyle),
                //               ),
                //             ),
                //             divider,
                //             Footer(),
                //           ]
                //         :
                [
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
                          onPressed: () {
                            _sceneId = _selectedScene.id;
                            // List eventAndScene = [_eventId, _sceneId];
                            // Navigator.pushNamed(context, Routes.sceneDetail,
                            //     arguments: eventAndScene);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SceneDetailPage(
                                      eventId: _eventId,
                                      sceneId: _sceneId,
                                    )));
                          },
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
                // bio: "참여자 : $teamMemberName",
              ),
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
      // String fileId = sceneList[i].fileId;
      String fileId = (i % 3).toString();
      items.add(ImageCarditem(
        image: Image.asset(
          'assets/images/scenes/${fileId}.jpg',
          fit: BoxFit.cover,
        ),
      ));
    }
    return items;
  }
}
