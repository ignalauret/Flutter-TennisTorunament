import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/models/player.dart';
import 'package:tennistournament/providers/ranking.dart';
import 'package:tennistournament/providers/tournaments.dart';
import 'package:tennistournament/screens/player_profile_screen.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/ranking/ranking_badge.dart';

class RankingPodium extends StatelessWidget {
  RankingPodium(this.players, this.selectedCategory);
  final List<Player> players;
  final String selectedCategory;

  final TextStyle whiteName = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  final TextStyle accentPoints =
      TextStyle(color: ACCENT_COLOR, fontSize: 13, fontWeight: FontWeight.bold);
  final TextStyle greyTournaments = TextStyle(
    color: BACKGROUND_COLOR,
    fontSize: 11,
  );

  Widget _buildPodium({
    int ranking,
    Player player,
    Size size,
    Tournaments tournamentData,
    BuildContext context,
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
          Navigator.of(context)
              .pushNamed(PlayerProfileScreen.routeName, arguments: player);
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
                  "Torneos jugados: ${tournamentData.getPlayersPlayedTournaments(player.id, selectedCategory)}",
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
    final rankingData = Provider.of<Ranking>(context);
    final tournamentData = Provider.of<Tournaments>(context);

    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(0),
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
          player: players[0],
          size: size,
          tournamentData: tournamentData,
          context: context,
        ),
        _buildPodium(
          ranking: 2,
          player: players[1],
          size: size,
          tournamentData: tournamentData,
          context: context,
        ),
        _buildPodium(
          ranking: 3,
          player: players[2],
          size: size,
          tournamentData: tournamentData,
          context: context,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.02,
          left:
              MediaQuery.of(context).size.width * 0.5 - 60 + size.width * 0.21,
          child: RankingBadge(
            rankingData.getRankingOf(players[0].id, selectedCategory),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.07,
          left: MediaQuery.of(context).size.width * 0.05 + size.width * 0.20,
          child: RankingBadge(
            rankingData.getRankingOf(players[1].id, selectedCategory),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.07,
          left: MediaQuery.of(context).size.width * 0.95 -
              size.width * 0.3 +
              size.width * 0.2,
          child: RankingBadge(
            rankingData.getRankingOf(players[2].id, selectedCategory),
          ),
        ),
      ],
    );
  }
}
