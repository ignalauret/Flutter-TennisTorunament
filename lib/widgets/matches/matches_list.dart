import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/providers/players.dart';
import 'package:tennistournament/utils/date_methods.dart';
import 'package:tennistournament/widgets/matches/matches_list_item.dart';
import '../../providers/matches.dart';

class MatchesList extends StatelessWidget {
  MatchesList({this.date});
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final matchesData = Provider.of<Matches>(context);
    final matchesList = matchesData.matches;
    if (date != null)
      matchesList.removeWhere((match) => !isSameDay(match.date, date));
    final playerData = Provider.of<Players>(context);
    return matchesList.isEmpty
        ? Center(
            child: Text("No hay partidos"),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              final match = matchesList[index];
              final name1 = playerData.getPlayerName(match.idPlayer1);
              final name2 = playerData.getPlayerName(match.idPlayer2);
              return MatchesListItem(
                name1: name1,
                name2: name2,
                result1: match.getColouredResult(true),
                result2: match.getColouredResult(false),
                isFirstWinner: match.isFirstWinner,
                date: match.date,
                tournament: match.tournament,
                round: match.round,
              );
            },
            itemCount: matchesList.length,
          );
  }
}
