import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vrp_frontend/utils/color.dart';
import 'package:vrp_frontend/utils/spacing.dart';
import 'package:vrp_frontend/utils/text.dart';
import 'package:vrp_frontend/utils/typography.dart';
import 'package:vrp_frontend/routes.dart';
import 'package:vrp_frontend/models/models.dart';
// import 'dart:js' as js;

class ImageWrapper extends StatelessWidget {
  final String image;

  const ImageWrapper({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24),
      child: Image.asset(
        image,
        width: width,
        height: width / 1.618,
        fit: BoxFit.cover,
      ),
    );
  }
}

class AddEventButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50),
      child: Align(
        alignment: Alignment.centerLeft,
        child: RawMaterialButton(
          onPressed: () {
            // js.context.callMethod(
            //     'alertMessage');
            Navigator.pushNamed(context, Routes.createEvent);
          },
          child: Text(
            '새 사건 등록',
            style: GoogleFonts.openSans(color: Colors.white, fontSize: 14),
          ),
          fillColor: Color(0xFF242424),
          padding: EdgeInsets.symmetric(horizontal: 16),
          elevation: 0,
          hoverElevation: 0,
          hoverColor: Color(0xFFC7C7C7),
          highlightElevation: 0,
          focusElevation: 0,
        ),
      ),
    );
  }
}

class TagWrapper extends StatelessWidget {
  final List<EventOptionButton> tags;
  const TagWrapper({Key key, this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: paddingBottom24,
        child: Wrap(
          spacing: 8,
          runSpacing: 0,
          children: <Widget>[...tags],
        ));
  }
}

class EventOptionButton extends StatelessWidget {
  final String tag;
  final Event event;
  const EventOptionButton({Key key, this.tag, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        switch (tag) {
          case "새 현장 등록":
            Navigator.pushNamed(context, Routes.createScene, arguments: event);
            break;
          case "현장 수정":
            break;
          case "참여자 수정":
            break;
          case "사건 수정":
            Navigator.pushNamed(context, Routes.updateEvent, arguments: event);
            break;
          case "사건 삭제":
            break;
          default:
        }
      },
      child: Text(
        tag,
        style: GoogleFonts.openSans(color: Colors.white, fontSize: 14),
      ),
      fillColor: Color(0xFF242424),
      padding: EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      hoverElevation: 0,
      hoverColor: Color(0xFFC7C7C7),
      highlightElevation: 0,
      focusElevation: 0,
    );
  }
}

class EventDetailButton extends StatelessWidget {
  final Function onPressed;

  const EventDetailButton({Key key, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hover = false;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return MouseRegion(
        onHover: (event) => setState(() => hover = true),
        onExit: (event) => setState(() => hover = false),
        child: OutlineButton(
          onPressed: onPressed,
          highlightedBorderColor: textPrimary,
          hoverColor: Colors.white,
          borderSide: BorderSide(color: textPrimary, width: 2),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "자세히 보기",
            style: TextStyle(
                fontSize: 14,
                color: hover ? Colors.white : textPrimary,
                letterSpacing: 1),
          ),
        ),
      );
    });
  }
}

class SceneDetailButton extends StatelessWidget {
  final Function onPressed;

  const SceneDetailButton({Key key, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hover = false;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return MouseRegion(
        onHover: (event) => setState(() => hover = true),
        onExit: (event) => setState(() => hover = false),
        child: OutlineButton(
          onPressed: onPressed,
          highlightedBorderColor: textPrimary,
          hoverColor: Colors.white,
          borderSide: BorderSide(color: textPrimary, width: 2),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "자세히 보기",
            style: TextStyle(
                fontSize: 14,
                color: hover ? Colors.white : textPrimary,
                letterSpacing: 1),
          ),
        ),
      );
    });
  }
}

const Widget divider = Divider(color: Color(0xFFEEEEEE), thickness: 1);
Widget dividerSmall = Container(
  width: 40,
  decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Color(0xFFA0A0A0),
        width: 1,
      ),
    ),
  ),
);

List<Widget> authorSection({String imageUrl, String name, String bio}) {
  return [
    divider,
    Container(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Row(
        children: <Widget>[
          if (imageUrl != null)
            Container(
              margin: EdgeInsets.only(right: 25),
              child: Material(
                shape: CircleBorder(),
                clipBehavior: Clip.hardEdge,
                color: Colors.transparent,
                child: Image.asset(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          Expanded(
            child: Column(
              children: <Widget>[
                if (name != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextHeadlineSecondary(text: name),
                  ),
                if (bio != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      bio,
                      style: bodyTextStyle,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  ];
}

class ListNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              Icons.keyboard_arrow_left,
              size: 25,
              color: textSecondary,
            ),
            Text("NEWER POSTS", style: buttonTextStyle),
          ],
        ),
        Spacer(),
        Row(
          children: <Widget>[
            Text("OLDER POSTS", style: buttonTextStyle),
            Icon(
              Icons.keyboard_arrow_right,
              size: 25,
              color: textSecondary,
            ),
          ],
        )
      ],
    );
  }
}

class Footer extends StatelessWidget {
  // TODO Add additional footer components (i.e. about, links, logos).
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextBody(text: "Konkuk Univ. Graduation Project © 2020"),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  // TODO replace with Post item model.
  final String imageUrl;
  final String title;
  final String description;

  const ListItem(
      {Key key, this.imageUrl, @required this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (imageUrl != null)
          Container(
            child: ImageWrapper(
              image: imageUrl,
            ),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom12,
            child: Text(
              title,
              style: headlineTextStyle,
            ),
          ),
        ),
        if (description != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: marginBottom12,
              child: Text(
                description,
                style: bodyTextStyle,
              ),
            ),
          ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: marginBottom24,
            child: EventDetailButton(
              onPressed: () => Navigator.pushNamed(context, Routes.eventDetail),
            ),
          ),
        ),
      ],
    );
  }
}
