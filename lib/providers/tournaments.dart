import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tennistournament/models/Draw.dart';
import 'package:tennistournament/models/tournament.dart';
import 'package:http/http.dart' as http;

class Tournaments extends ChangeNotifier {
  final List<Tournament> _tournaments = [];
//    Tournament(
//        id: "0",
//        name: "Australian Open",
//        club: "Las Delicias",
//        players: {
//          "A": ["0", "2", "3"],
//          "B": ["7", "2", "3"],
//          "C": ["7", "3", "2"],
//        },
//        start: DateTime(2020, 5, 13),
//        end: DateTime(2020, 5, 16),
//        draws: {
//          "A": Draw({
//            "Cuartos de Final": ["0", "0", "0", "0"],
//            "Semifinal": ["0", "1"],
//            "Final": ["0"]
//          }),
//          "B": Draw({
//            "Semifinal": ["0", "1"],
//            "Final": ["0"]
//          }),
//          "C": Draw({
//            "Semifinal": ["0", "1"],
//            "Final": ["0"]
//          })
//        }),
//    Tournament(
//      id: "1",
//      name: "US Open",
//      club: "Las Delicias",
//      players: {
//        "A": ["2", "1", "7"],
//        "B": ["0", "1", "2"],
//        "C": ["0", "1", "2"],
//      },
//      start: DateTime(2020, 5, 13),
//      end: DateTime(2020, 5, 15),
//    ),
//  ];

  Future<List<Tournament>> fetchTournaments() async {
    if(_tournaments.isNotEmpty) return [..._tournaments];
    final response = await http.get("https://tennis-tournament-4990d.firebaseio.com/tournaments.json");
    final responseData = json.decode(response.body) as List<dynamic>;
    for(int i = 0; i < responseData.length; i++) {
      final Map<String, dynamic> tournamentData = responseData[i];
      _tournaments.add(Tournament.fromJson(i.toString(), tournamentData));
    }
    return [..._tournaments];
  }

  Tournament getTournamentById(String id) {
    return _tournaments.firstWhere((tournament) => tournament.id == id);
  }

  String getTournamentName(String id) {
    return getTournamentById(id).name;
  }

  int getPlayerTitles(String id) {
    int result = 0;
    _tournaments
        .forEach((tournament) => result += tournament.getPlayerTitles(id));
    return result;
  }

  int getPlayersPlayedTournaments(String id) {
    int result = 0;
    _tournaments.forEach(
        (tournament) => result += tournament.getPlayerParticipation(id));
    return result;
  }
}
