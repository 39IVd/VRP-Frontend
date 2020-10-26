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
                      child: Text("VR Crimescene Project",
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
                      child: Text("VR을 활용한 실제 범죄현장 재구성 소프트웨어",
                          style: headlineSecondaryTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: marginBottom24,
                      child: Text("건국대학교 컴퓨터공학부 4학년 졸업프로젝트",
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
                      child: Text("소개", style: headlineTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: marginBottom24,
                      child: Text(
                          "360도 공간 모델링과 Image Feature Matching을 이용한 VR 범죄현장 재구성 소프트웨어\n 범죄현장의 전체 공간과 증거물들을 촬영한 이미지들을 조합하여, 가상 공간에서 현장을 재구성하고 분석할 수 있는 소프트웨어",
                          style: headlineSecondaryTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: marginBottom24,
                      child: Text("개요", style: subtitleTextStyle),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: marginBottom40,
                      child: Text(
                          "이 프로젝트는 수사관과 집행자 사이에 발생할 수 있는 문제점 감소 및 사건 이해도 증진을 목표로 한다.\n첫째, 사건이 일어난 현장을 그대로 재구성하여 판사나 검사가 사건을 파악할 수 있다면, 수사 자체에 도움이 되는 것은 물론, 현장에 와 보지 않은 검사와 판사가 현장을 더 사실적으로 이해하고 범죄 혐의에 대한 심증을 굳히는데 크게 기여할 수 있을 것이다.\n둘째, 오래 전 사건을 재수사하는 경우에 가상으로 복원된 당시의 현장을 볼 수 있다면, 이후 현장이 훼손되거나 사건을 담당한 경찰관이 기억을 하지 못하더라도 전체적인 범죄 현장을 파악할 수 있을 것이다.",
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
