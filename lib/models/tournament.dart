import 'package:flutter/cupertino.dart';
import 'package:tennistournament/models/Draw.dart';

class Tournament {
  Tournament({
    @required this.id,
    @required this.name,
    @required this.club,
    @required this.players,
    @required this.start,
    @required this.end,
    this.winners = const {"A": "0", "B": "", "C": ""},
    this.draws,
  });

  final String id;
  final String name;
  final String club;
  final Map<String, List<String>> players;
  final DateTime start;
  final DateTime end;
  final Map<String, String> winners;
  final Map<String, Draw> draws;

  int get playerCount {
    int result = 0;
    players.forEach((key, playersList) => result += playersList.length);
    return result;
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
