import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import '../providers/players.dart';
import '../providers/ranking.dart';
import '../utils/constants.dart';
import '../utils/text_styles.dart';
import '../widgets/category_buttons.dart';
import '../widgets/players/players_list.dart';
import '../widgets/ranking/ranking_podium.dart';

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
            decoration: BoxDecoration(
                color: MAIN_COLOR,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(BORDER_RADIUS),
                  bottomLeft: Radius.circular(BORDER_RADIUS),
                )),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 0,
                    left: size.width * 0.05,
                    right: size.width * 0.05,
                    bottom: 0,
                  ),
                  color: MAIN_COLOR,
                  child: CategoryButtons(selectCategory, selectedCategory),
                ),
                RankingPodium([
                  playerData.getPlayerById(ranking[0]),
                  playerData.getPlayerById(ranking[1]),
                  playerData.getPlayerById(ranking[2]),
                ], selectedCategory),
              ],
            ),
          ),
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
                    style: kSmallTitleStyle,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Jugados",
                    style: kSmallTitleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  child: Text(
                    "Puntos",
                    style: kSmallTitleStyle,
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
