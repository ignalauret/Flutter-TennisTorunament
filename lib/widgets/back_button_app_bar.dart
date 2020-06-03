import 'package:flutter/material.dart';
import '../utils/text_styles.dart';
import '../widgets/tennis_back_button.dart';

class BackButtonAppBar extends StatelessWidget {
  BackButtonAppBar({this.title = ""});
  final String title;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TennisBackButton(),
        Container(
          width: size.width - 140,
          height: 50,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              title,
              style: kMainTitleStyle,
            ),
          ),
        )
      ],
    );
  }
}
