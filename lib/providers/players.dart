import 'package:flutter/material.dart';
import 'package:tennistournament/models/player.dart';

class Players extends ChangeNotifier {
  List<Player> _players = [
    Player(
      name: "Ignacio Lauret",
      birth: DateTime(1998, 10, 15),
      id: "0",
      points: {"A": 100, "B": 50, "C": 30},
      profileUrl: "assets/img/Djokovic.png",
    ),
    Player(
      name: "Agustin Arancio",
      birth: DateTime(1995, 8, 23),
      id: "1",
      points: {"A": 80, "B": 30, "C": 20},
      profileUrl: "assets/img/Federer.png",
    ),
    Player(
      name: "Damian Giusti",
      birth: DateTime(1993, 6, 10),
      id: "2",
      points: {"A": 60, "B": 20, "C": 20},
      profileUrl: "assets/img/Nadal.png",
    ),
    Player(
      name: "Ignacio Zazu",
      birth: DateTime(1980, 6, 10),
      id: "3",
      points: {"A": 90, "B": 0, "C": 0},
      profileUrl: "assets/img/Zverev.png",
    ),
  ];

  List<Player> get players {
    return [..._players];
  }

  String getPlayerName(String id) {
    return getPlayerById(id).name;
  }

  int getPlayerPoints(String id, String category) {
    return getPlayerById(id).points[category];
  }

  String getPlayerImage(String id) {
    return getPlayerById(id).profileUrl;
  }

  Player getPlayerById(String id) {
    return _players.firstWhere((player) => player.id == id);
  }
}
