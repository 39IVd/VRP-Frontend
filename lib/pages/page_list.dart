import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:minimal/components/components.dart';
import 'package:minimal/models/models.dart';

const String listItemTitleText = "A BETTER BLOG FOR WRITING";
const String listItemPreviewText =
    "Sed elementum tempus egestas sed sed risus. Mauris in aliquam sem fringilla ut morbi tincidunt. Placerat vestibulum lectus mauris ultrices eros. Et leo duis ut diam. Auctor neque vitae tempus […]";

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool isLogin = false;
  List<Event> eventList = List();
  Widget _buildCard(Event event) {
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
                Text(event.eventName),
                Text(event.address1),
                Text(event.happenedAt),
                Text(event.eventStatus),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    eventList = dummyEventList;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: <Widget>[
                  MenuBar(),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(eventList.length, (index) {
                      return _buildCard(eventList[index]);
                    }),
                  ),
                  // ListItem(
                  //     imageUrl:
                  //         "assets/images/paper_flower_overhead_bw_w1080.jpg",
                  //     title: listItemTitleText,
                  //     description: listItemPreviewText),
                  divider,
                  // ListItem(
                  //     imageUrl:
                  //         "assets/images/iphone_cactus_tea_overhead_bw_w1080.jpg",
                  //     title: listItemTitleText,
                  //     description: listItemPreviewText),
                  // divider,
                  // ListItem(
                  //     imageUrl:
                  //         "assets/images/typewriter_overhead_bw_w1080.jpg",
                  //     title: listItemTitleText,
                  //     description: listItemPreviewText),
                  // divider,
                  // ListItem(
                  //     imageUrl:
                  //         "assets/images/coffee_paperclips_pencil_angled_bw_w1080.jpg",
                  //     title: listItemTitleText,
                  //     description: listItemPreviewText),
                  // divider,
                  // ListItem(
                  //     imageUrl:
                  //         "assets/images/joy_note_coffee_eyeglasses_overhead_bw_w1080.jpg",
                  //     title: listItemTitleText,
                  //     description: listItemPreviewText),
                  // divider,
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 80),
                  //   child: ListNavigation(),
                  // ),
                  // divider,
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
