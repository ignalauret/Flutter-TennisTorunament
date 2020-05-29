import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/models/player.dart';
import 'package:tennistournament/models/tournament.dart';
import 'package:tennistournament/providers/players.dart';
import 'package:tennistournament/providers/ranking.dart';
import 'package:tennistournament/screens/tournament_draw_screen.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/category_buttons.dart';
import 'package:tennistournament/widgets/players/players_list.dart';
import 'package:tennistournament/widgets/ranking/ranking_badge.dart';
import 'package:tennistournament/widgets/ranking/ranking_podium.dart';

class TournamentDetailScreen extends StatefulWidget {
  static const routeName = "/tournament";

  @override
  _TournamentDetailScreenState createState() => _TournamentDetailScreenState();
}

class _TournamentDetailScreenState extends State<TournamentDetailScreen> {
  String selectedCategory = "A";

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
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style:
                  TextStyle(color: ACCENT_COLOR, fontWeight: FontWeight.bold),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              date,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullWidthStat(String label, String value, Size size) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
        horizontal: size.width * 0.025,
      ),
      color: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BORDER_RADIUS),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        child: Row(
          children: <Widget>[
            Container(
              width: size.width * 0.20,
              child: Text(
                label,
                style: TextStyle(
                  color: ACCENT_COLOR,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
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
    final size = MediaQuery.of(context).size;
    final Tournament tournament = ModalRoute.of(context).settings.arguments;
    final playerData = Provider.of<Players>(context);
    final ranking = Provider.of<Ranking>(context);
    final tournamentPlayerList = tournament.players;
    tournamentPlayerList.forEach(
      (category, playerList) => playerList.sort(
        (id1, id2) => ranking
            .getRankingOfInt(id1, selectedCategory)
            .compareTo(ranking.getRankingOfInt(id2, selectedCategory)),
      ),
    );
    return Scaffold(
      backgroundColor: MAIN_COLOR,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: size.height * 0.30,
                  width: size.width,
                  margin: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Image.network(
                    "https://vignette.wikia.nocookie.net/logopedia/images/a/a9/Austopen2017.png/revision/latest/scale-to-width-down/340?cb=20171231140337",
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
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 5, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            tournament.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildFullWidthStat("Ubicación", tournament.club, size),
                  _buildFullWidthStat(
                      "Fecha",
                      "Del " +
                          DateFormat("d/M").format(tournament.start) +
                          " al " +
                          DateFormat("d/M").format(tournament.end),
                      size),
                  CategoryButtons(selectCategory, selectedCategory),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      tournament.getActualRound(selectedCategory) == "Terminado"
                          ? _buildBigStat(
                              "Campeón",
                              playerData.getPlayerName(
                                  tournament.getWinnerId(selectedCategory)),
                              "Inscriptos: ${tournament.getInitialPlayersOfCat(selectedCategory).toString()}",
                              size)
                          : _buildBigStat(
                              "Jugadores Restantes",
                              tournament
                                  .getRemainingPlayers(selectedCategory)
                                  .toString(),
                              "Inscriptos: ${tournament.getInitialPlayersOfCat(selectedCategory).toString()}",
                              size),
                      _buildBigStat(
                          "Ronda actual",
                          tournament.getActualRound(selectedCategory),
                          "Inicio: ${tournament.getStartingRound(selectedCategory)}",
                          size),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Preclasificados",
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
                                  "Ver Cuadro",
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
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                TournamentDrawScreen.routeName,
                                arguments: {
                                  "tournament": tournament,
                                  "selectedCategory": selectedCategory
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                  RankingPodium([
                    playerData.getPlayerById(
                        tournamentPlayerList[selectedCategory][0]),
                    playerData.getPlayerById(
                        tournamentPlayerList[selectedCategory][1]),
                    playerData.getPlayerById(
                        tournamentPlayerList[selectedCategory][2]),
                  ], selectedCategory),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
