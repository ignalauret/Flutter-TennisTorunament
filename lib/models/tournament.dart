import 'package:flutter/cupertino.dart';
import 'package:tennistournament/models/Draw.dart';
import 'package:tennistournament/utils/date_methods.dart';
import 'package:tennistournament/utils/parsers.dart';

class Tournament {
  Tournament({
    @required this.id,
    @required this.name,
    @required this.club,
    @required this.players,
    @required this.start,
    @required this.end,
    this.winners = const {"A": "", "B": "", "C": ""},
    this.draws,
  });

  Tournament.fromJson(String id, Map<String, dynamic> tournamentData)
      : id = id,
        name = tournamentData["name"],
        club = tournamentData["club"],
        start = parseDate(tournamentData["start"]),
        end = parseDate(tournamentData["end"]),
        winners = tournamentData["winners"] == null
            ? {}
            : Map<String, String>.from(tournamentData["winners"]),
        players =
            parsePlayers(Map<String, List>.from(tournamentData["players"])),
        draws = parseDraws(Map<String, List>.from(tournamentData["draws"]));

  final String id;
  final String name;
  final String club;
  final Map<String, List<String>> players;
  final DateTime start;
  final DateTime end;
  final Map<String, String> winners;
  final Map<String, Draw> draws;

  /* Getters */

  String getWinnerId(String category) {
    return winners[category];
  }

  int getInitialPlayers() {
    int result = 0;
    players.forEach((_, list) {
      if (list.length == 1) return;
      result += list.length;
    });
    return result;
  }

  int getInitialPlayersOfCat(String category) {
    return players[category].length;
  }

  int getRemainingPlayers(String category) {
    // Remaining Players = Initial players - Matches played
    final playedMatches = draws[category].draw.fold(
        0, (prev, match) => match[match.length - 1] == "," ? prev : prev + 1);
    return getInitialPlayersOfCat(category) - playedMatches;
  }

  String getStartingRound(String category) {
    return draws[category].startingRound;
  }

  String getActualRound(String category) {
    return draws[category].actualRound;
  }

  bool isWinner(String id, String category) {
    return winners[category] == id;
  }

  int getPlayerTitles(String id) {
    int result = 0;
    winners.forEach((category, pid) {
      if (pid == id) result++;
    });
    return result;
  }

  int getPlayerParticipation(String id) {
    int result = 0;
    players.values.forEach((playersList) {
      if (playersList.contains(id)) result++;
    });
    return result;
  }
}
