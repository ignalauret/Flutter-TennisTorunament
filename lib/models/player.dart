import 'package:flutter/material.dart';

enum Backhand {OneHanded, TwoHanded}
enum Handed {Right, Left}


class Player {
  Player({
    @required this.id,
    @required this.name,
    @required this.birth,
    @required this.points,
    @required this.nationality,
    @required this.club,
    this.profileUrl,
    this.imageUrl,
    this.backhand = Backhand.TwoHanded,
    this.handed = Handed.Right
  });

  final String id;
  final String name;
  final DateTime birth;
  final Map<String, int> points;
  final String profileUrl;
  final String imageUrl;
  final Backhand backhand;
  final Handed handed;
  final String nationality;
  final String club;


  int get age {
    final now = DateTime.now();
    final years = now.year - birth.year;
    if (now.month < birth.month) return years - 1;
    if (now.month == birth.month && now.day < birth.day) return years - 1;
    return years;
  }

  String get backhandType {
    return backhand == Backhand.OneHanded ? "Una mano" : "Dos manos";
  }

  String get hand {
    return handed == Handed.Right ? "Derecha" : "Izquierda";
  }

  int getPointsOfCategory(String category) {
    return points[category];
  }

  bool playsCategory(String category) {
    return points[category] != 0;
  }
}
