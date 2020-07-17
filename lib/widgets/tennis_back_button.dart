import 'package:flutter/material.dart';
import '../utils/text_styles.dart';
import '../utils/constants.dart';

import '../custom_icons_icons.dart';

class TennisBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 100,
      child: FlatButton(
        padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Icon(
                CustomIcons.back_bounce,
                color: ACCENT_COLOR,
                size: 25,
              ),
            ),
            SizedBox(
              width: 2,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Volver",
                style: kButtonTextStyle,
              ),
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
    );
  }
}
