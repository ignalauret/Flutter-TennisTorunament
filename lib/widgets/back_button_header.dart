import 'package:flutter/material.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/tennis_back_button.dart';

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
          top: size.height * 0.04,
          left: size.width * 0.03,
          width: 80,
          child: TennisBackButton(),
        ),
        Positioned(
          top: size.height * 0.04 + 10,
          right: size.width * 0.03,
          width: size.width - 120,
          height: 20,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
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
