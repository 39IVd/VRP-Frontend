import 'package:flutter/material.dart';
import 'package:vrp_frontend/components/components.dart';
import 'package:vrp_frontend/utils/utils.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/keys.dart';
import '../models/models.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom12,
                      child: Text("HOME", style: headlineTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom24,
                      child: Text("Text styles for pages and posts.",
                          style: subtitleTextStyle),
                    ),
                  ),
                  divider,
                  Container(
                    margin: marginBottom40,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom12,
                      child: Text("Basic Styles",
                          style: headlineSecondaryTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom24,
                      child: Text("Simple to remember and use",
                          style: subtitleTextStyle),
                    ),
                  ),
                  dividerSmall,
                  Container(
                    margin: marginBottom24,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: marginBottom24,
                      child: Text("Headline", style: headlineTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: marginBottom24,
                      child: Text("Headline Secondary",
                          style: headlineSecondaryTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: marginBottom24,
                      child: Text("Subtitle", style: subtitleTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: marginBottom40,
                      child: Text(
                          "Body text is the default text style. Use this text style for website content and paragraphs. This text is chosen to be easy and comfortable to read. As the default text style for large blocks of text, particular attention is placed on the choice of font. Some fonts are more comfortable to read than others.",
                          style: bodyTextStyle),
                    ),
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