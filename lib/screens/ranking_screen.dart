import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/players/players_list.dart';
import 'package:tennistournament/widgets/ranking_badge.dart';

class RankingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const TextStyle whiteName = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    const TextStyle accentPoints = TextStyle(
      color: ACCENT_COLOR,
      fontSize: 13,
    );
    final TextStyle greyTournaments = TextStyle(
      color: BACKGROUND_COLOR,
      fontSize: 11,
    );
    final TextStyle greyTitle = TextStyle(
      color: Colors.grey[700],
      fontSize: 14,
    );
    return Container(
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.28,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(BORDER_RADIUS),
                    bottomRight: Radius.circular(BORDER_RADIUS),
                  ),
                  color: MAIN_COLOR,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.06,
                left: MediaQuery.of(context).size.width * 0.5 - 60,
                child: Container(
                  height: 130,
                  width: 120,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        child: Image.asset("assets/img/Djokovic.png"),
                        radius: 40,
                      ),
                      Text(
                        "Ignacio Lauret",
                        style: whiteName,
                      ),
                      Text(
                        "2050 puntos",
                        style: accentPoints,
                      ),
                      Text(
                        "Torneos jugados: 3",
                        style: greyTournaments,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.06,
                left: MediaQuery.of(context).size.width * 0.5 - 60 + 80,
                child: RankingBadge("1"),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.03 + 60,
                left: MediaQuery.of(context).size.width * 0.1 - 20,
                child: Container(
                  height: 120,
                  width: 110,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        child: Image.asset("assets/img/Djokovic.png"),
                        radius: 35,
                      ),
                      Text(
                        "Ignacio Lauret",
                        style: whiteName,
                      ),
                      Text(
                        "2050 puntos",
                        style: accentPoints,
                      ),
                      Text(
                        "Torneos jugados: 3",
                        style: greyTournaments,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.03 + 60,
                left: MediaQuery.of(context).size.width * 0.1 - 20 + 75,
                child: RankingBadge("2"),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.03 + 60,
                left: MediaQuery.of(context).size.width * 0.9 - 90,
                child: Container(
                  height: 120,
                  width: 110,
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        child: Image.asset("assets/img/Djokovic.png"),
                        radius: 35,
                      ),
                      Text(
                        "Ignacio Lauret",
                        style: whiteName,
                      ),
                      Text(
                        "2050 puntos",
                        style: accentPoints,
                      ),
                      Text(
                        "Torneos jugados: 3",
                        style: greyTournaments,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.03 + 60,
                left: MediaQuery.of(context).size.width * 0.9 - 100 + 75,
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
                    style: greyTitle,
                    textAlign: TextAlign.start,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Torneos Jugados",
                    style: greyTitle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.12,
                  child: Text(
                    "Puntos",
                    style: greyTitle,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.72 - 45 - 20,
            child: PlayersList(),
          ),
        ],
      ),
    );
  }
}
