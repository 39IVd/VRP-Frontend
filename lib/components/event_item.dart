import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minimal/routes.dart';
import 'package:minimal/models/models.dart';
import 'components.dart';

class EventItem extends StatelessWidget {
  final Event event;
  const EventItem({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        // width: MediaQuery.of(context).size.width / 0.2,
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
                  'assets/images/iphone_cactus_tea_overhead_bw_w1080.jpg',
                  height: 200,
                  fit: BoxFit.fitWidth,
                ),
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
                      event.address1,
                      style: bodyTextStyle,
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
                    child: EventDetailButton(
                      onPressed: () => Navigator.pushNamed(context, Routes.post,
                          arguments: event),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
