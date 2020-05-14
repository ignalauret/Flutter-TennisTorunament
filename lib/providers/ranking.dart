import 'package:flutter/foundation.dart';
import 'package:tennistournament/models/player.dart';

class Ranking extends ChangeNotifier {
  Ranking(this.players);
  final List<String> ranking = [];
  final List<Player> players;

  List<String> fetchRanking() {
    if (ranking.isNotEmpty) return ranking;
    players
        .sort((player1, player2) => player2.points.compareTo(player1.points));
    return players.map((player) => player.id).toList();
  }
}
