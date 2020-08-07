import 'package:flutter/material.dart';
import 'package:tennistournament/models/Draw.dart';
import 'package:tennistournament/providers/matches.dart';
import 'package:tennistournament/utils/parsers.dart';

class Tournament {
  Tournament(
      {@required this.id,
      @required this.name,
      @required this.club,
      @required this.players,
      @required this.start,
      @required this.end,
      this.winners,
      this.draws,
      this.logoUrl});

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
        draws = parseDraws(Map<String, List>.from(tournamentData["draws"])),
        logoUrl = tournamentData["logoUrl"];

  final String id;
  final String name;
  final String club;
  final Map<String, List<String>> players;
  final DateTime start;
  final DateTime end;
  final Map<String, String> winners;
  final Map<String, Draw> draws;
  final String logoUrl;

  /* Getters */

  String getWinnerId(String category) {
    return winners[category];
  }

  List<String> getCategories() {
    List<String> result = [];
    for (String category in Categories) {
      if (players.containsKey(category)) result.add(category);
    }
    return result;
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

  bool hasPlayed(String id, String category) {
    if (players.containsKey(category)) {
      return players[category].contains(id);
    }
    return false;
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
