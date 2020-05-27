import 'package:flutter/material.dart';
import 'package:tennistournament/utils/constants.dart';

class BackButtonHeader extends StatelessWidget {
  BackButtonHeader({this.title = ""});
  final String title;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          height: size.height * 0.05,
          width: size.width,
          margin: const EdgeInsets.only(top: 30, bottom: 10),
        ),
        Positioned(
          top: size.height * 0.03,
          left: size.width * 0.03,
          width: 80,
          child: FlatButton(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.arrow_back,
                  color: ACCENT_COLOR,
                  size: 20,
                ),
                Text(
                  "Volver",
                  style: BUTTON_STYLE,
                ),
              ],
            ),
            color: Colors.black45,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        Positioned(
          top: size.height * 0.03 + 16,
          right: size.width * 0.03,
          width: size.width * 0.5,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TITLE_STYLE,
            ),
          ),
        )
      ],
    );
  }
}
