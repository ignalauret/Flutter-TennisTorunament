import 'package:flutter/cupertino.dart';
import 'package:tennistournament/models/match.dart';

class Matches extends ChangeNotifier {
  final List<Match> _matches = [
    Match(
      idPlayer1: "0",
      idPlayer2: "1",
      result1: ["6", "6", "6"],
      result2: ["0", "7", "3"],
      date: DateTime(2020, 5, 14, 16, 30),
      tournament: "Ausralian Open A",
      round: "Segunda Ronda",
    ),
    Match(
      idPlayer1: "0",
      idPlayer2: "2",
      result1: ["6", "6"],
      result2: ["3", "3"],
      date: DateTime(2020, 5, 13, 18, 00),
      tournament: "Ausralian Open B",
      round: "Semifinal",
    ),
  ];

  List<Match> get matches {
    return [..._matches];
  }

  Map<String, int> getPlayerStats(String id) {
    final matches = _matches
        .where((match) => match.idPlayer1 == id || match.idPlayer2 == id);
    final wins = matches.fold(
        0, (prev, match) => match.winnerId == id ? prev + 1 : prev);
    final tournaments = 1; //TODO
    return {"played": matches.length, "wins": wins, "tournaments": tournaments};
  }
}
