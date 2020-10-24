import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

class Routes {
  static const String home = "/";
  static const String about = "about";
  static const String login = 'login';
  static const String join = 'join';
  static const String demo = 'demo';
  static const String mypage = 'mypage';
  static const String eventList = 'eventList';
  static const String eventDetail = "eventDetail";
  static const String createEvent = 'createEvent';
  static const String updateEvent = 'updateEvent';
  static const String homePage = 'homePage';
  static const String createScene = 'createScene';
  static const String updateScene = 'updateScene';
  static const String sceneDetail = 'sceneDetail';

  static Route<T> fadeThrough<T>(RouteSettings settings, WidgetBuilder page,
      {int duration = 300}) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeScaleTransition(animation: animation, child: child);
      },
    );
  }
}
