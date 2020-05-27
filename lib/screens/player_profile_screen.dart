import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/models/player.dart';
import 'package:tennistournament/providers/matches.dart';
import 'package:tennistournament/providers/ranking.dart';
import 'package:tennistournament/providers/tournaments.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/utils/stats_methods.dart';
import 'package:tennistournament/widgets/category_buttons.dart';
import 'package:tennistournament/widgets/matches/matches_list.dart';

class PlayerProfileScreen extends StatefulWidget {
  static const routeName = "/profile";

  @override
  _PlayerProfileScreenState createState() => _PlayerProfileScreenState();
}

class _PlayerProfileScreenState extends State<PlayerProfileScreen> {
  String selectedCategory = "A";

  final TextStyle infoTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  Widget _buildStat(String label, String value, Size size) {
    return Container(
      height: size.height * 0.06,
      width: size.width * 0.3,
      padding: EdgeInsets.all(size.height * 0.005),
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01, horizontal: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
        color: Colors.black45,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: TextStyle(color: ACCENT_COLOR, fontSize: 12),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBigStat(String label, String value, String date, Size size) {
    return Container(
      height: 70,
      width: size.width * 0.45,
      padding: EdgeInsets.all(size.height * 0.005),
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.025,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
        color: Colors.black45,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(color: ACCENT_COLOR, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            date,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Player player = ModalRoute.of(context).settings.arguments;
    final size = MediaQuery.of(context).size;
    final rankingData = Provider.of<Ranking>(context);
    final matchesData = Provider.of<Matches>(context);
    final playerStats = matchesData.getPlayerStats(player.id);
    final tournamentsData = Provider.of<Tournaments>(context);
    return Scaffold(
      backgroundColor: MAIN_COLOR,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: size.height * 0.57,
                  width: size.width,
                  child: Image.asset(
                    player.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: size.height * 0.03,
                  left: size.width * 0.03,
                  width: 80,
                  child: FlatButton(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, right: 10, left: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back,
                          color: ACCENT_COLOR,
                          size: 20,
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
                ),
                Positioned(
                  left: 0,
                  top: size.height * 0.1,
                  child: Container(
                    height: size.height * 0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        _buildStat("Nombre", player.name, size),
                        _buildStat("Edad", player.age.toString(), size),
                        _buildStat("Mano hábil", player.hand, size),
                        _buildStat("Reves", player.backhandType, size),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: size.height * 0.5,
                  child: Container(
                    height: size.height * 0.08,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: MAIN_COLOR,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(BORDER_RADIUS),
                        topRight: Radius.circular(BORDER_RADIUS),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: size.width * 0.5,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/img/argentina_flag.png",
                                height: 20,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  player.nationality,
                                  style: infoTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: size.width * 0.5,
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.fitness_center,
                                size: 25,
                                color: ACCENT_COLOR,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  player.club,
                                  style: infoTextStyle,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  CategoryButtons(selectCategory, selectedCategory),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildBigStat(
                          "Ranking Actual",
                          rankingData.getRankingOf(player.id, selectedCategory),
                          player.points[selectedCategory].toString() +
                              " puntos",
                          size),
                      _buildBigStat(
                          "Mejor Ranking",
                          player.bestRankings[selectedCategory] == 1000
                              ? "-"
                              : player.bestRankings[selectedCategory]
                                  .toString(),
                          player.bestRankingsDates[selectedCategory],
                          size),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildBigStat(
                          "Titulos",
                          tournamentsData.getPlayerTitles(player.id, selectedCategory).toString(),
                          "Jugados: ${tournamentsData.getPlayersPlayedTournaments(player.id, selectedCategory)}",
                          size),
                      _buildBigStat(
                          "Victorias",
                          playerStats[selectedCategory]["wins"].toString(),
                          "Ratio: ${getWinsRatio(playerStats[selectedCategory]["played"], playerStats[selectedCategory]["wins"])}",
                          size),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Partidos recientes",
                          style: TITLE_STYLE,
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.025),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.025),
                        child: FlatButton(
                          padding: const EdgeInsets.only(
                            right: 2,
                            top: 10,
                            left: 10,
                            bottom: 10,
                          ),
                          child: Row(
                            children: <Widget>[
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Ver Todos",
                                  style: BUTTON_STYLE,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: ACCENT_COLOR,
                                size: 20,
                              ),
                            ],
                          ),
                          color: Colors.black45,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(BORDER_RADIUS),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: MatchesList(
                      playerId: player.id,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
