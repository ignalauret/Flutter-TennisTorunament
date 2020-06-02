import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:provider/provider.dart';
import 'package:tennistournament/models/player.dart';
import 'package:tennistournament/providers/matches.dart';
import 'package:tennistournament/providers/tournaments.dart';
import 'package:tennistournament/screens/player_profile_screen.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/h2h/head_to_head_stat.dart';

class HeadToHead extends StatelessWidget {
  HeadToHead(this.player1, this.player2);
  final Player player1;
  final Player player2;

  Widget _buildImagesRow({
    String imageUrl1,
    String imageUrl2,
    int wins1,
    int wins2,
    BuildContext context,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 100,
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(PlayerProfileScreen.routeName, arguments: player1),
            child: Image.asset(
              imageUrl1,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: 120,
                width: 120,
                child: charts.PieChart(
                  [
                    new charts.Series<int, int>(
                      id: 'VS',
                      domainFn: (int value, _) => value,
                      measureFn: (int value, _) => value,
                      colorFn: (int value, _) => value == min(wins1, wins2)
                          ? charts.ColorUtil.fromDartColor(
                              ACCENT_COLOR.withAlpha(120))
                          : charts.ColorUtil.fromDartColor(ACCENT_COLOR),
                      data: [wins2, wins1],
                    )
                  ],
                  animate: true,
                  animationDuration: Duration(milliseconds: 500),
                  defaultRenderer: charts.ArcRendererConfig(
                    arcWidth: 10,
                  ),
                ),
              ),
              Text(
                "$wins1:$wins2",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 100,
          child: InkWell(
            onTap: () => Navigator.of(context).pushNamed(PlayerProfileScreen.routeName, arguments: player2),
            child: Image.asset(
              imageUrl2,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final tournamentData = Provider.of<Tournaments>(context);
    final matchesData = Provider.of<Matches>(context);
    final size = MediaQuery.of(context).size;
    final versus = matchesData.getVersus(player1.id, player2.id);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: <Widget>[
          _buildImagesRow(
            imageUrl1: player1.profileUrl,
            imageUrl2: player2.profileUrl,
            wins1: versus[0],
            wins2: versus[1],
            context: context,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 2),
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: size.width * 0.5 - 25,
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      player1.name,
                      style: TITLE_STYLE,
                    ),
                  ),
                ),
                Container(
                  width: size.width * 0.5 - 25,
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      player2.name,
                      style: TITLE_STYLE,
                    ),
                  ),
                ),
              ],
            ),
          ),
          HeadToHeadStat(
              "Edad",
              player1.age.toString() +
                  " (${DateFormat("d.M.yyyy").format(player1.birth)})",
              "(${DateFormat("d.M.yyyy").format(player2.birth)}) " +
                  player2.age.toString(),
              false),
          HeadToHeadStat("Club", player1.club, player2.club, false),
          HeadToHeadStat("Mano hábil", player1.hand, player2.hand, false),
          HeadToHeadStat(
              "Revés", player1.backhandType, player2.backhandType, false),
          HeadToHeadStat(
              "Títulos",
              tournamentData.getAllPlayerTitles(player1.id).toString(),
              tournamentData.getAllPlayerTitles(player2.id).toString(),
              true),
          HeadToHeadStat(
              "Victorias",
              matchesData.getAllPlayerWins(player1.id).toString(),
              matchesData.getAllPlayerWins(player2.id).toString(),
              true),
          HeadToHeadStat(
              "% Victorias",
              matchesData.getWinRatio(player1.id).toString(),
              matchesData.getWinRatio(player2.id).toString(),
              true),
        ],
      ),
    );
  }
}
