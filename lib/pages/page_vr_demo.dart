
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vrp_frontend/components/components.dart';
import 'package:vrp_frontend/utils/utils.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';
import 'package:flutter_html/style.dart';
import 'dart:convert';
import 'package:easy_web_view/easy_web_view.dart';
import 'dart:js' as js;
import 'dart:html' as html;
import '../utils/UiFake.dart' if (dart.library.html) 'dart:ui' as ui;

class VRDemoPage extends StatefulWidget {
  @override
  _VRDemoPageState createState() => _VRDemoPageState();
}

class _VRDemoPageState extends State<VRDemoPage> {
 
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      String viewID = "your-view-id";
       ui.platformViewRegistry.registerViewFactory(
        viewID,
            (int id) => html.IFrameElement()
          ..width = MediaQuery.of(context).size.width.toString()
          ..height = MediaQuery.of(context).size.height.toString()
          ..src = '../../../assets/index.html'
          ..style.border = 'none');
    
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
              SizedBox(
                height: 1000,
                child: HtmlElementView(
                  viewType: viewID,
                ),
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

