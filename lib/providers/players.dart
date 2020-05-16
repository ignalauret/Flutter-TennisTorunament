import 'package:flutter/material.dart';
import 'package:tennistournament/models/player.dart';

class Players extends ChangeNotifier {
  List<Player> _players = [
    Player(
      name: "Ignacio Lauret",
      birth: DateTime(1998, 10, 15),
      id: "0",
      points: {"A": 550, "B": 50, "C": 30},
      profileUrl: "assets/img/ignacio_lauret_profile.png",
      imageUrl: "assets/img/ignacio_lauret_image.png",
      backhand: Backhand.OneHanded,
      nationality: "Córdoba, Córdoba",
      club: "Las Delicias Tenis",
    ),
    Player(
      name: "Agustin Arancio",
      birth: DateTime(1995, 8, 23),
      id: "1",
      points: {"A": 80, "B": 30, "C": 20},
      profileUrl: "assets/img/Federer.png",
      backhand: Backhand.TwoHanded,
      nationality: "Córdoba, Córdoba",
      club: "Il tempo",
    ),
    Player(
      name: "Damian Giusti",
      birth: DateTime(1992, 8, 22),
      id: "2",
      points: {"A": 500, "B": 20, "C": 20},
      profileUrl: "assets/img/damian_giusti_profile.png",
      imageUrl: "assets/img/damian_giusti_image.png",
      backhand: Backhand.OneHanded,
      nationality: "Santa Fe, Rosario",
      club: "Las Delicias Tenis",
    ),
    Player(
      name: "Ignacio Zazu",
      birth: DateTime(1978, 8, 3),
      id: "3",
      points: {"A": 520, "B": 0, "C": 0},
      profileUrl: "assets/img/ignacio_zazu_profile.png",
      imageUrl: "assets/img/ignacio_zazu_image.png",
      backhand: Backhand.OneHanded,
      nationality: "Córdoba, Córdoba",
      club: "Las Delicias Tenis",
    ),
    Player(
      name: "Maxi Breide",
      birth: DateTime(1980, 6, 10),
      id: "4",
      points: {"A": 80, "B": 0, "C": 0},
      profileUrl: "assets/img/Zverev.png",
      backhand: Backhand.TwoHanded,
    ),
    Player(
      name: "Jorge Barbe",
      birth: DateTime(1980, 6, 10),
      id: "5",
      points: {"A": 85, "B": 0, "C": 0},
      profileUrl: "assets/img/jorge_barbe_profile.png",
      imageUrl: "assets/img/jorge_barbe_image.png",
      backhand: Backhand.OneHanded,
    ),
    Player(
      name: "Pablo Ferreyra",
      birth: DateTime(1980, 6, 10),
      id: "6",
      points: {"A": 30, "B": 0, "C": 0},
      profileUrl: "assets/img/Zverev.png",
      backhand: Backhand.OneHanded,
    ),
    Player(
      name: "Gustavo Carbonari",
      birth: DateTime(1980, 6, 10),
      id: "7",
      points: {"A": 250, "B": 190, "C": 300},
      profileUrl: "assets/img/gustavo_carbonari_profile.png",
      backhand: Backhand.OneHanded,
    ),
    Player(
      name: "Mariano Moll",
      birth: DateTime(1980, 6, 10),
      id: "8",
      points: {"A": 200, "B": 200, "C": 250},
      profileUrl: "assets/img/mariano_moll_profile.png",
      backhand: Backhand.OneHanded,
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
