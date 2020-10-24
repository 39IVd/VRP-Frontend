import 'package:flutter/material.dart';
import 'package:vrp_frontend/pages/page_mypage.dart';
import 'package:vrp_frontend/pages/event_page/page_create_event.dart';
import 'package:vrp_frontend/pages/pages.dart';
import 'package:vrp_frontend/pages/scene_page/page_create_scene.dart';
import 'package:vrp_frontend/routes.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    (() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        isLogin = prefs.getBool('isLogin') ?? false;
      });
    })();
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget),
          maxWidth: 1700,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K")
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      initialRoute: Routes.home,
      onGenerateRoute: (RouteSettings settings) {
        return Routes.fadeThrough(settings, (context) {
          switch (settings.name) {
            case Routes.home:
              return isLogin ? EventListPage() : HomePage();
            case Routes.homePage:
              return HomePage();
            case Routes.eventList:
              return EventListPage();
            case Routes.eventDetail:
              return EventDetailPage();
            case Routes.about:
              return AboutPage();
            case Routes.login:
              return LoginPage();
            case Routes.join:
              return JoinPage();
            case Routes.demo:
              return DemoPage();
            case Routes.mypage:
              return MyPage();
            case Routes.createEvent:
              return CreateEventPage();
            case Routes.updateEvent:
              return UpdateEventPage();
            case Routes.createScene:
              return CreateScenePage();
            case Routes.updateScene:
              return UpdateScenePage();
            case Routes.sceneDetail:
              return SceneDetailPage();
            default:
              return null;
          }
        });
      },
      theme: Theme.of(context).copyWith(platform: TargetPlatform.android),
      debugShowCheckedModeBanner: false,
    );
  }
}
