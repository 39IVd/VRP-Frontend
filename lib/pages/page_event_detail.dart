import 'package:flutter/material.dart';
import 'package:minimal/components/components.dart';
import 'package:minimal/models/models.dart';

class EventDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Event event = ModalRoute.of(context).settings.arguments;
    String participantsName = '';
    event.participants.map((e) => e.name).toList().forEach((element) {
      participantsName += element + '  ';
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: <Widget>[
              NavigationBar(),
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
              Image.asset(
                'assets/images/iphone_cactus_tea_overhead_bw_w1080.jpg',
                height: 400,
                fit: BoxFit.fitWidth,
              ),
              // ImageWrapper(
              //   image: "assets/images/mugs_side_bw_w1080.jpg",
              // ),

              Align(
                alignment: Alignment.centerLeft,
                child: TextHeadlineSecondary(text: '주소 : ${event.address1}'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child:
                    TextHeadlineSecondary(text: '일시 : ${event.eventStartedAt}'),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextHeadlineSecondary(text: '상태 : ${event.eventStatus}'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TagWrapper(tags: [
                      EventOptionButton(tag: "현장 사진 등록"),
                      EventOptionButton(tag: "현장 사진 관리"),
                    ]),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TagWrapper(tags: [
                      EventOptionButton(tag: "사건 수정"),
                      EventOptionButton(tag: "참여자 수정"),
                      EventOptionButton(tag: "사건 삭제")
                    ]),
                  ),
                ],
              ),

              ...authorSection(
                  imageUrl: "assets/images/avatar_default.png",
                  name: "팀장 : ${event.supervisor.name}",
                  bio: "참여자 : $participantsName"),
              Container(
                padding: EdgeInsets.symmetric(vertical: 80),
                child: EventNavigation(),
              ),
              divider,
              Footer(),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
