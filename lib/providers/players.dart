import 'package:flutter/material.dart';
import 'package:tennistournament/models/player.dart';

class Players extends ChangeNotifier {
  List<Player> _players = [
    Player(name: "Ignacio Lauret", birth: DateTime(1998, 10, 15), id: "0", points: 100),
    Player(name: "Agustin Arancio", birth: DateTime(1995, 8, 23), id: "1", points: 10),
    Player(name: "Damian Giusti", birth: DateTime(1993, 6, 10), id: "2", points: 40),
  ];

  List<Player> get players {
    return [..._players];
  }

  String getPlayerName(String id) {
    return _players.firstWhere((player) => player.id == id).name;
  }

  int getPlayerPoints(String id) {
    return _players.firstWhere((player) => player.id == id).points;
  }
}
