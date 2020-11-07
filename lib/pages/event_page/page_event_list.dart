import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vrp_frontend/components/components.dart';
import 'package:vrp_frontend/models/models.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/models.dart';
import 'package:vrp_frontend/dummylist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventListPage extends StatefulWidget {
  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  bool isLogin = false;
  String _accessToken;
  List<Event> eventList = List();
  @override
  void initState() {
    super.initState();
    (() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _accessToken = prefs.getString('_accessToken');
      });
    })();
  }

  Future<List<Event>> getMyEvents() async {
    List<Event> eventList = List();
    final http.Response response = await http.get(
        // TODO:
        'https://jsonplaceholder.typicode.com/albums/1');
    Map<String, dynamic> json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      // Map<String, dynamic> events = json['data']['events'];
      List events = json['data']['events'];
      // TODO:
      // for (var e in events) {
      //   String eventId = events['eventId'];
      //   String createdAt = events['createdAt'];
      //   String eventStartedAt = events['eventStartedAt'];
      //   String eventStatus = events['eventStatus'];
      //   String eventName = events['eventName'];
      //   String teamLeader = events['teamLeader'];
      // }
      return eventList;
    } else if (response.statusCode == 401) {
      // 허가되지 않은 유저
      // TODO:
      String message = json['message'];
      print(message);
      throw Exception(message);
    } else {
      throw Exception('왜인지 모르겠지만 실패함');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final User user = ModalRoute.of(context).settings.arguments;

    eventList = dummyEventList;
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
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(eventList.length, (index) {
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
