import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/providers/players.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/back_button_header.dart';
import 'package:tennistournament/widgets/matches/matches_list.dart';

class PlayerMatchesScreen extends StatelessWidget {
  static const routeName = "/player-matches";
  @override
  Widget build(BuildContext context) {
    final String playerId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: MAIN_COLOR,
      body: Column(
        children: <Widget>[
          BackButtonHeader(
            title:
                "Partidos de ${Provider.of<Players>(context, listen: false).getPlayerName(playerId)}",
          ),
          Expanded(
            child: MatchesList(
              playerId: playerId,
            ),
          ),
        ],
      ),
    );
  }
}
