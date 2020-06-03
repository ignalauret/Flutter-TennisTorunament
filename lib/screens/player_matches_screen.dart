import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/providers/players.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/back_button_app_bar.dart';
import 'package:tennistournament/widgets/matches/matches_list.dart';

class PlayerMatchesScreen extends StatelessWidget {
  static const routeName = "/player-matches";
  @override
  Widget build(BuildContext context) {
    final String playerId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: BackButtonAppBar(
          title:
              "Partidos de ${Provider.of<Players>(context, listen: false).getPlayerName(playerId)}",
        ),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: MAIN_COLOR,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: MatchesList(
          playerId: playerId,
        ),
      ),
    );
  }
}
