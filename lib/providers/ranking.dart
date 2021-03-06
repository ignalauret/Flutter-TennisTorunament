import 'package:flutter/foundation.dart';
import 'package:tennistournament/models/player.dart';

class Ranking extends ChangeNotifier {
  Ranking(this._players);
  final Map<String, List<String>> ranking = {};
  final List<Player> _players;

  List<String> fetchRanking(String category) {
    if (ranking[category] != null) return ranking[category];
    final playersList = [..._players];
    playersList.retainWhere((player) => player.playsCategory(category));
    playersList.sort(
      (player1, player2) =>
          player2.points[category].compareTo(player1.points[category]),
    );
    final result = playersList.map((player) => player.id).toList();
    ranking.addAll({category: result});
    return result;
  }

  String getRankingOf(String id, String category) {
    final ranking = fetchRanking(category);
    final index = ranking.indexOf(id);
    if(index == -1) return "-";
    return (index + 1).toString();
  }

  int getRankingOfInt(String id, String category) {
    final ranking = fetchRanking(category);
    final index = ranking.indexOf(id);
    if(index == -1) return 1000;
    return (index + 1);
  }
}
