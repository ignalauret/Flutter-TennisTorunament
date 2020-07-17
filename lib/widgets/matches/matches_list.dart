import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/models/match.dart';
import 'package:tennistournament/providers/players.dart';
import 'package:tennistournament/providers/ranking.dart';
import 'package:tennistournament/providers/tournaments.dart';
import 'package:tennistournament/screens/match_detail_screen.dart';
import 'package:tennistournament/utils/date_methods.dart';
import 'package:tennistournament/utils/text_styles.dart';
import 'package:tennistournament/widgets/matches/matches_list_item.dart';
import '../../providers/matches.dart';

class MatchesList extends StatelessWidget {
  MatchesList({
    this.date,
    this.playerId,
    this.playerId2,
    this.tournamentId,
    this.selectedCategory,
    this.dontShowMatch,
    this.search,
    this.scrollable = true,
    this.reversed = false,
  });

  final DateTime date;
  final String playerId;
  final String playerId2;
  final String tournamentId;
  final String selectedCategory;
  final String dontShowMatch;
  final String search;
  final bool scrollable;
  final bool reversed;
  @override
  Widget build(BuildContext context) {
    final tournamentsData = Provider.of<Tournaments>(context, listen: false);
    final matchesData = Provider.of<Matches>(context, listen: false);
    final playerData = Provider.of<Players>(context, listen: false);
    final rankingData = Provider.of<Ranking>(context, listen: false);
    return FutureBuilder<List<Match>>(
      future: matchesData.fetchMatches(),
      builder: (ctx, snapshot) {
        if (snapshot == null || snapshot.data == null)
          return Center(
            child: CircularProgressIndicator(),
          );
        final List<Match> matchesList =
            reversed ? snapshot.data.reversed.toList() : snapshot.data;
        // Remove bye matches.
        matchesList.removeWhere(
            (match) => match.idPlayer1 == "-1" || match.idPlayer2 == "-1");
        // Show matches of date.
        if (date != null)
          matchesList.removeWhere((match) => !isSameDay(match.date, date));
        // Show matches of player.
        if (playerId != null)
          matchesList.retainWhere((match) =>
              match.idPlayer1 == playerId || match.idPlayer2 == playerId);
        // Show matches of versus
        if (playerId2 != null)
          matchesList.retainWhere((match) =>
              match.idPlayer1 == playerId2 || match.idPlayer2 == playerId2);
        // Show matches of tournament.
        if (tournamentId != null)
          matchesList.retainWhere((match) =>
              match.tournament == tournamentId &&
              match.category == selectedCategory);
        // Dont show match
        if (dontShowMatch != null)
          matchesList.removeWhere((match) => match.id == dontShowMatch);
        // Keep the ones that match the search.
        if (search != null) {
          matchesList.retainWhere((match) =>
              playerData.getPlayerName(match.idPlayer1).contains(search) ||
              playerData.getPlayerName(match.idPlayer2).contains(search));
        }

        return matchesList.isEmpty
            ? Container(
                height: 155,
                width: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  "No hay partidos",
                  style: kSmallTitleStyle,
                ),
              )
            : Container(
                height: matchesList.length * 155.0,
                child: ListView.builder(
                  physics: scrollable ? null : NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (ctx, index) {
                    final match = matchesList[index];
                    final name1 = playerData.getPlayerName(match.idPlayer1);
                    final name2 = playerData.getPlayerName(match.idPlayer2);
                    final tournament =
                        tournamentsData.getTournamentById(match.tournament);
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            MatchDetailScreen.routeName,
                            arguments: match);
                      },
                      child: MatchesListItem(
                        name1: name1,
                        name2: name2,
                        ranking1: rankingData.getRankingOf(
                            match.idPlayer1, match.category),
                        ranking2: rankingData.getRankingOf(
                            match.idPlayer2, match.category),
                        result1: match.getColouredResult(true),
                        result2: match.getColouredResult(false),
                        isFirstWinner: match.isFirstWinner,
                        date: match.date,
                        tournament: tournament.name + " " + match.category,
                        round: match.round,
                      ),
                    );
                  },
                  itemCount: matchesList.length,
                ),
              );
      },
    );
  }
}
