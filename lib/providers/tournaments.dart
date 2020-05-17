import 'package:flutter/foundation.dart';
import 'package:tennistournament/models/tournament.dart';

class Tournaments extends ChangeNotifier {
  final List<Tournament> _tournaments = [
    Tournament(
      id: "0",
      name: "Australian Open",
      club: "Las Delicias",
      players: {
        "A": ["0", "1", "2"],
        "B": ["2", "1", "3"],
        "C": ["7", "3", "2"],
      },
      start: DateTime(2020, 5, 13),
      end: DateTime(2020, 5, 16),
    ),
    Tournament(
      id: "1",
      name: "US Open",
      club: "Las Delicias",
      players: {
        "A": ["2", "1"],
        "B": ["0", "1", "2"],
        "C": ["0", "1", "2"],
      },
      start: DateTime(2020, 5, 13),
      end: DateTime(2020, 5, 15),
    ),
  ];

  List<Tournament> fetchTournaments() {
    return [..._tournaments];
  }

  Tournament getTournamentById(String id) {
    return _tournaments.firstWhere((tournament) => tournament.id == id);
  }

  String getTournamentName(String id) {
    return getTournamentById(id).name;
  }
}
