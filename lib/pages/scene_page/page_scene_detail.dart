import 'package:flutter/material.dart';
import 'package:vrp_frontend/components/components.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vrp_frontend/utils/utils.dart';
import '../../models/models.dart';

class SceneDetailPage extends StatefulWidget {
  @override
  _SceneDetailPageState createState() => _SceneDetailPageState();
}

class _SceneDetailPageState extends State<SceneDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Scene scene = ModalRoute.of(context).settings.arguments;
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
                    "Scene Detail",
                    style: headlineTextStyle,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: marginBottom12,
                  child: Text(
                    scene.sceneName,
                    style: headlineTextStyle,
                  ),
                ),
              ),
              Container(height: 30),
              dividerSmall,
              Container(height: 30),
              divider,
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}