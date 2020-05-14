import 'package:flutter/material.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/matches/matches_list.dart';
import 'package:tennistournament/widgets/players/players_list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Text(
          "Partidos",
          style: TITLE_STYLE,
        ),
        Container(
          height: size.height * 0.37,
          child: MatchesList(),
        ),
        Text(
          "Ranking",
          style: TITLE_STYLE,
        ),
        Container(
          height: size.height * 0.3,
          child: PlayersList(),
        ),
      ],
    );
  }
}
