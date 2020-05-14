import 'package:flutter/material.dart';

class Player {
  Player({@required this.id, @required this.name, @required this.birth, this.points});

  final String id;
  final String name;
  final DateTime birth;
  final int points;

  int get age {
    final now = DateTime.now();
    final years = now.year - birth.year;
    if(now.month < birth.month) return years - 1;
    if(now.month == birth.month && now.day < birth.day) return years - 1;
    return years;
  }
}
