import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/models/match.dart';
import 'package:tennistournament/models/tournament.dart';
import 'package:bidirectional_scroll_view/bidirectional_scroll_view.dart';
import 'package:tennistournament/providers/matches.dart';
import 'package:tennistournament/providers/players.dart';
import 'package:tennistournament/providers/ranking.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/utils/math_methods.dart';
import 'package:tennistournament/widgets/matches/DrawMatchCard.dart';

class TournamentDraw extends StatelessWidget {
  TournamentDraw(this.tournament, this.selectedCategory);
  final Tournament tournament;
  final String selectedCategory;

  Widget _buildMatchCard(
    Match match,
    Players playerData,
    Ranking rankingData,
    double margin,
  ) {
    final name1 = playerData.getPlayerName(match.idPlayer1);
    final name2 = playerData.getPlayerName(match.idPlayer2);
    return Container(
      height: DRAW_MATCH_HEIGHT,
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: margin),
      alignment: Alignment.center,
      child: DrawMatchCard(
        name1: name1,
        name2: name2,
        ranking1: rankingData.getRankingOf(match.idPlayer1, match.category),
        ranking2: rankingData.getRankingOf(match.idPlayer2, match.category),
        result1: match.getColouredResult(true),
        result2: match.getColouredResult(false),
        isFirstWinner: match.isFirstWinner,
      ),
    );
  }

  Widget _buildRoundColumn(List<String> matches, String title,
      Matches matchesData, Players playerData, Ranking rankingData) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TITLE_STYLE,
        ),
        ...matches.map(
          (match) => _buildMatchCard(
            matchesData.getMatchById(match),
            playerData,
            rankingData,
            getMargin(tournament.draws[selectedCategory], matches.length),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final matchesData = Provider.of<Matches>(context);
    final playerData = Provider.of<Players>(context);
    final rankingData = Provider.of<Ranking>(context);
    return BidirectionalScrollViewPlugin(
      child: Container(
        height: 1000,
        width: 1000,
        child: Row(
          children: tournament.draws[selectedCategory].getSortedDraw().entries
              .map(
                (entry) => _buildRoundColumn(entry.value, entry.key,
                    matchesData, playerData, rankingData),
              )
              .toList(),
        ),
      ),
    );
  }
}
