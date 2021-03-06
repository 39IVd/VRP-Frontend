import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vrp_frontend/routes.dart';
import 'package:vrp_frontend/models/models.dart';
import 'components.dart';
import 'package:vrp_frontend/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventItem extends StatelessWidget {
  final Event event;
  const EventItem({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('width : ${MediaQuery.of(context).size.width}');
    return Container(
        padding: const EdgeInsets.all(20),
        // width: MediaQuery.of(context).size.width * 0.2,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/crimescene.jpg',
                  height: 220,
                  fit: BoxFit.fitWidth,
                ),
                Container(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: marginBottom12,
                    child: Text(
                      event.eventName,
                      style: headlineTextStyle,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: marginBottom12,
                    child: Text(
                      event.eventStartedAt,
                      style: bodyTextStyle,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: marginBottom12,
                    child: Text(
                      event.eventStatus,
                      style: bodyTextStyle,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: marginBottom24,
                    // 자세히 보기
                    child: EventDetailButton(
                      onPressed: () {
                        (() async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setInt('eventId', event.eventId);
                          print("event selected : ${event.eventId}");
                        })();
                        // TODO:
                        // Navigator.pushNamed(context, Routes.eventDetail);
                        Navigator.pushNamed(context, Routes.eventDetail,
                            arguments: event);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
