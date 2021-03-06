import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tennistournament/models/player.dart';
import 'package:http/http.dart' as http;

class Players extends ChangeNotifier {
  List<Player> _players = [];

  Future<List<Player>> fetchPlayers() async {
    if(_players.isNotEmpty) return [..._players];
    final response = await http.get("https://tennis-tournament-4990d.firebaseio.com/players.json");
    final responseData = json.decode(response.body) as List<dynamic>;
    for(int i = 0; i < responseData.length; i++) {
      final Map<String, dynamic> playerData = responseData[i];
      _players.add(Player.fromJson(i.toString(), playerData));
    }
    notifyListeners();
    return [..._players];
  }

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
