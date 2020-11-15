import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrp_frontend/components/components.dart';
import 'package:vrp_frontend/models/models.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/models.dart';
import 'package:vrp_frontend/dummylist.dart';
import 'package:vrp_frontend/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  bool isLogin = false;
  String _accessToken;
  List<Event> eventList = List();
  bool _eventLoaded = false;
  @override
  void initState() {
    super.initState();
    (() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _accessToken = prefs.getString('accessToken');
      });
      print("accessToken in initstate : $_accessToken");
      List events = await getMyEvents();
      setState(() {
        eventList = events;
        _eventLoaded = true;
      });
    })();
  }

  Future<List<Event>> getMyEvents() async {
    List<Event> eventList = List();
    print("accessToken in func : $_accessToken");
    final http.Response response = await http.get(
      'http://localhost:8081/events',
      headers: <String, String>{
        'Authorization': _accessToken,
      },
    );
    Map<String, dynamic> json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      eventList = (json['data']['events'] as List)
          .map((e) => Event.fromJson(e))
          .toList();
      for (var e in eventList) {
        print(e.eventName);
      }
    } else if (response.statusCode == 401) {
      // 허가되지 않은 유저입니다
      String message = json['message'];
      showFlushBar(context, message);
    }
    return eventList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: <Widget>[
                  NavigationBar(),
                  AddEventButton(),
                  !_eventLoaded
                      ? Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 200, 0, 200),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : eventList.isEmpty
                          ? Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 200, 0, 200),
                                child:
                                    Text("NO EVENTS", style: headlineTextStyle),
                              ),
                            )
                          : GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(20),
                              physics: NeverScrollableScrollPhysics(),
                              children:
                                  List.generate(eventList.length, (index) {
                                return EventItem(event: eventList[index]);
                              }),
                            ),
                  divider,
                  Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
