import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/providers/players.dart';
import 'package:tennistournament/providers/ranking.dart';
import 'package:tennistournament/providers/tournaments.dart';
import 'package:tennistournament/utils/constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<Players>(context, listen: false).fetchPlayers();
    Provider.of<Tournaments>(context, listen: false).fetchTournaments();
    Provider.of<Ranking>(context, listen: false).fetchRanking("A");
    return Column(
      children: <Widget>[
        SizedBox(
          height: 15,
        ),
        Text(
          "Partidos",
          style: TITLE_STYLE,
        ),
        Text(
          "Ranking",
          style: TITLE_STYLE,
        ),
      ],
    );
  }
}
