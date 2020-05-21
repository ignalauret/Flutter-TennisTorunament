import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/models/player.dart';
import 'package:tennistournament/providers/players.dart';
import 'package:tennistournament/providers/ranking.dart';
import 'package:tennistournament/screens/player_profile_screen.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/category_buttons.dart';
import 'package:tennistournament/widgets/players/players_list.dart';
import 'package:tennistournament/widgets/ranking/ranking_badge.dart';
import 'package:tennistournament/widgets/ranking/ranking_podium.dart';

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  String selectedCategory = "A";

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ranking =
        Provider.of<Ranking>(context).fetchRanking(selectedCategory);
    final playerData = Provider.of<Players>(context);
    playerData.fetchPlayers();
    return Container(
      color: BACKGROUND_COLOR,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 30,
              left: size.width * 0.05,
              right: size.width * 0.05,
              bottom: 3,
            ),
            color: MAIN_COLOR,
            child: CategoryButtons(selectCategory, selectedCategory),
          ),
          RankingPodium([
            playerData.getPlayerById(ranking[0]),
            playerData.getPlayerById(ranking[1]),
            playerData.getPlayerById(ranking[2]),
          ], selectedCategory),
          Container(
            height: 20,
            padding: const EdgeInsets.only(right: 23, left: 48),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nombre",
                    style: SMALL_TITLE_STYLE,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Torneos Jugados",
                    style: SMALL_TITLE_STYLE,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  child: Text(
                    "Puntos",
                    style: SMALL_TITLE_STYLE,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: PlayersList(selectedCategory, ranking.sublist(3)),
          ),
        ],
      ),
    );
  }
}
