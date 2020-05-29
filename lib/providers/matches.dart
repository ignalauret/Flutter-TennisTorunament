import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tennistournament/models/match.dart';
import 'package:http/http.dart' as http;
import 'package:tennistournament/utils/stats_methods.dart';

const Categories = ["A", "B", "C"];

class Matches extends ChangeNotifier {
  final List<Match> _matches = [];

  Future<List<Match>> fetchMatches() async {
    if (_matches.isNotEmpty) return [..._matches];
    final response = await http
        .get("https://tennis-tournament-4990d.firebaseio.com/matches.json");
    final responseData = json.decode(response.body) as List<dynamic>;
    for (int i = 0; i < responseData.length; i++) {
      final Map<String, dynamic> tournamentData = responseData[i];
      _matches.add(Match.fromJson(i.toString(), tournamentData));
    }
    return [..._matches];
  }

  /* Getters */

  Match getMatchById(String id) {
    return _matches.firstWhere((match) => match.id == id);
  }

  int getPlayedMatches(String id, String category) {
    final matches = _matches.where((match) =>
        (match.idPlayer1 == id || match.idPlayer2 == id) &&
        match.category == category);
    return matches.length;
  }

  int getPlayerWins(String id, String category) {
    final matches = _matches.where((match) =>
        (match.idPlayer1 == id || match.idPlayer2 == id) &&
        match.category == category &&
        match.winnerId == id);
    return matches.length;
  }

  int getWinRatio(String id) {
    return getWinsRatio(getAllPlayedMatches(id), getAllPlayerWins(id));
  }

  int getAllPlayerWins(String id) {
    int result = 0;
    Categories.forEach((category) {
      result += getPlayerWins(id, category);
    });
    return result;
  }

  int getAllPlayedMatches(String id) {
    int result = 0;
    Categories.forEach((category) {
      result += getPlayedMatches(id, category);
    });
    return result;
  }

  List<int> getVersus(String id1, String id2) {
    final List<int> result = [0,0];
    _matches.forEach((match) {
      // Check if the match is between both players.
      if ((match.idPlayer1 == id1 && match.idPlayer2 == id2) ||
          (match.idPlayer1 == id2 && match.idPlayer2 == id1)) {
        // Add one to the winner count.
        if(match.winnerId == id1) {
          result[0]++;
        } else {
          result[1]++;
        }
      }
    });
    return result;
  }
}
