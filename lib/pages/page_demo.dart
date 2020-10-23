import 'package:flutter/material.dart';
import 'package:vrp_frontend/components/components.dart';
import 'package:vrp_frontend/utils/utils.dart';

class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(
    //     child: Panorama(
    //       child: Image.asset('assets/images/panorama.jpg'),
    //     ),
    //   ),
    // );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: <Widget>[
              NavigationBar(),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: marginBottom12,
                  child: Text(
                    "VR Demo",
                    style: headlineTextStyle,
                  ),
                ),
              ),
              // Panorama(
              //   child: Image.asset('assets/scene.jpg'),
              // ),
              ImageWrapper(
                image: "assets/images/mugs_side_bw_w1080.jpg",
              ),
              TextBlockquote(text: "This is VR Crimescnene Demo Page."),
              Align(
                alignment: Alignment.centerLeft,
                child: TagWrapper(tags: [
                  EventOptionButton(tag: "Share"),
                  EventOptionButton(tag: "Details"),
                ]),
              ),
              Footer(),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
