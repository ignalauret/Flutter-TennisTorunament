import 'package:flutter/material.dart';
import '../utils/constants.dart';

import '../custom_icons_icons.dart';

class TennisBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 80,
      child: FlatButton(
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              CustomIcons.back_bounce,
              color: ACCENT_COLOR,
              size: 20,
            ),
            SizedBox(
              width: 2,
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
    );
  }
}
