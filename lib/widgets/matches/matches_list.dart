import 'package:flutter/material.dart';
import 'package:intl/date_time_patterns.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/providers/players.dart';
import 'package:tennistournament/providers/ranking.dart';
import 'package:tennistournament/providers/tournaments.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/utils/date_methods.dart';
import 'package:tennistournament/widgets/matches/matches_list_item.dart';
import '../../providers/matches.dart';

class MatchesList extends StatelessWidget {
  MatchesList(
      {this.date, this.playerId, this.tournamentId, this.selectedCategory});
  final DateTime date;
  final String playerId;
  final String tournamentId;
  final String selectedCategory;
  @override
  Widget build(BuildContext context) {
    final tournamentsData = Provider.of<Tournaments>(context);
    final matchesData = Provider.of<Matches>(context);
    final playerData = Provider.of<Players>(context);
    //final rankingData = Provider.of<Ranking>(context);
    return FutureBuilder(
      future: matchesData.fetchMatches(),
      builder: (ctx, snapshot) {
        if (snapshot == null || snapshot.data == null)
          return Center(
            child: CircularProgressIndicator(),
          );
        final matchesList = snapshot.data;
        if (date != null)
          matchesList.removeWhere((match) => !isSameDay(match.date, date));
        if (playerId != null)
          matchesList.retainWhere((match) =>
              match.idPlayer1 == playerId || match.idPlayer2 == playerId);
        if (tournamentId != null)
          matchesList.retainWhere((match) =>
              match.tournament == tournamentId &&
              match.category == selectedCategory);
        return matchesList.isEmpty
            ? Container(
                height: 140,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "No hay partidos",
                  style: TITLE_STYLE,
                ),
              )
            : Container(
                height: matchesList.length * 140.0,
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (ctx, index) {
                    final match = matchesList[index];
                    final name1 = playerData.getPlayerName(match.idPlayer1);
                    final name2 = playerData.getPlayerName(match.idPlayer2);
                    final tournament =
                        tournamentsData.getTournamentById(match.tournament);
                    return MatchesListItem(
                      name1: name1,
                      name2: name2,
                      ranking1: "1",
                      ranking2: "2",
//                      ranking1: rankingData.getRankingOf(
//                          match.idPlayer1, match.category),
//                      ranking2: rankingData.getRankingOf(
//                          match.idPlayer2, match.category),
                      result1: match.getColouredResult(true),
                      result2: match.getColouredResult(false),
                      isFirstWinner: match.isFirstWinner,
                      date: match.date,
                      tournament: tournament.name + " " + match.category,
                      round: match.round,
                    );
                  },
                  itemCount: matchesList.length,
                ),
              );
      },
    );
  }
}
