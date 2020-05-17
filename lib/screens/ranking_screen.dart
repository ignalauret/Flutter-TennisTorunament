import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/models/player.dart';
import 'package:tennistournament/providers/players.dart';
import 'package:tennistournament/providers/ranking.dart';
import 'package:tennistournament/screens/player_profile_screen.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/players/players_list.dart';
import 'package:tennistournament/widgets/ranking_badge.dart';

class RankingScreen extends StatefulWidget {
  @override
  _RankingScreenState createState() => _RankingScreenState();
}

class _RankingScreenState extends State<RankingScreen> {
  final TextStyle whiteName = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  final TextStyle accentPoints = TextStyle(
    color: ACCENT_COLOR,
    fontSize: 13,
    fontWeight: FontWeight.bold
  );
  final TextStyle greyTournaments = TextStyle(
    color: BACKGROUND_COLOR,
    fontSize: 11,
  );

  String selectedCategory = "A";

  Widget _buildCategoryButton(String text, bool selected) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.30,
      child: FlatButton(
        padding: const EdgeInsets.all(15),
        onPressed: () {
          setState(() {
            selectedCategory = text.substring(text.length - 1);
          });
        },
        color: selected ? Colors.black38 : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: TextStyle(
              color: selected ? ACCENT_COLOR : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPodium({
    int ranking,
    Player player,
    Size size,
  }) {
    return Positioned(
      top: ranking == 1 ? size.height * 0.02 : size.height * 0.07,
      left: ranking == 1
          ? size.width * 0.5 - 60
          : ranking == 2
              ? size.width * 0.05
              : size.width * 0.95 - size.width * 0.30,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(PlayerProfileScreen.routeName, arguments: player);
        },
        child: Container(
          height: size.height * 0.20,
          width: size.width * 0.30,
          child: Column(
            children: <Widget>[
              CircleAvatar(
                child: Image.asset(player.profileUrl),
                backgroundColor: Colors.black38,
                radius: ranking == 1
                    ? min(size.height * 0.08, size.width * 0.10)
                    : min(size.height * 0.06, size.width * 0.08),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  player.name,
                  style: whiteName,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "${player.points[selectedCategory]} puntos",
                  style: accentPoints,
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Torneos jugados: 1",
                  style: greyTournaments,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ranking =
        Provider.of<Ranking>(context).fetchRanking(selectedCategory);
    final playerData = Provider.of<Players>(context);
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 30,
              left: size.width * 0.05,
              right: size.width * 0.05,
            ),
            height: 80,
            color: MAIN_COLOR,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildCategoryButton("Categoria A", selectedCategory == "A"),
                _buildCategoryButton("Categoria B", selectedCategory == "B"),
                _buildCategoryButton("Categoria C", selectedCategory == "C"),
              ],
            ),
          ),
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(BORDER_RADIUS),
                    bottomRight: Radius.circular(BORDER_RADIUS),
                  ),
                  color: MAIN_COLOR,
                ),
              ),
              _buildPodium(
                ranking: 1,
                player: playerData.getPlayerById(ranking[0]),
                size: size,
              ),
              _buildPodium(
                ranking: 2,
                player: playerData.getPlayerById(ranking[1]),
                size: size,
              ),
              _buildPodium(
                ranking: 3,
                player: playerData.getPlayerById(ranking[2]),
                size: size,
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.5 -
                    60 +
                    size.width * 0.21,
                child: RankingBadge("1"),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.07,
                left: MediaQuery.of(context).size.width * 0.05 +
                    size.width * 0.20,
                child: RankingBadge("2"),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.07,
                left: MediaQuery.of(context).size.width * 0.95 -
                    size.width * 0.3 +
                    size.width * 0.2,
                child: RankingBadge("3"),
              ),
            ],
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
          Container(
            height: MediaQuery.of(context).size.height * 0.75 - 45 - 20 - 80,
            child: PlayersList(selectedCategory, ranking.sublist(3)),
          ),
        ],
      ),
    );
  }
}
