import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/providers/players.dart';
import 'package:tennistournament/providers/ranking.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/utils/date_methods.dart';
import 'package:tennistournament/widgets/matches/matches_list_item.dart';
import '../../providers/matches.dart';

class MatchesList extends StatelessWidget {
  MatchesList({this.date, this.playerId});
  final DateTime date;
  final String playerId;
  @override
  Widget build(BuildContext context) {
    final matchesData = Provider.of<Matches>(context);
    final matchesList = matchesData.matches;
    if (date != null)
      matchesList.removeWhere((match) => !isSameDay(match.date, date));
    if (playerId != null)
      matchesList.retainWhere((match) =>
          match.idPlayer1 == playerId || match.idPlayer2 == playerId);
    final playerData = Provider.of<Players>(context);
    final rankingData = Provider.of<Ranking>(context);
    return matchesList.isEmpty
        ? Container(
            height: 140,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text("No hay partidos", style: TITLE_STYLE,),
          )
        : Container(
            height: matchesList.length * 140.0,
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemBuilder: (ctx, index) {
                final match = matchesList[index];
                final name1 = playerData.getPlayerName(match.idPlayer1);
                final name2 = playerData.getPlayerName(match.idPlayer2);
                return MatchesListItem(
                  name1: name1,
                  name2: name2,
                  ranking1:
                      rankingData.getRankingOf(match.idPlayer1, match.category),
                  ranking2:
                      rankingData.getRankingOf(match.idPlayer2, match.category),
                  result1: match.getColouredResult(true),
                  result2: match.getColouredResult(false),
                  isFirstWinner: match.isFirstWinner,
                  date: match.date,
                  tournament: match.tournament,
                  round: match.round,
                );
              },
              itemCount: matchesList.length,
            ),
          );
  }
}
