import 'package:flutter/material.dart';

class Match {
  Match({
    @required this.idPlayer1,
    @required this.idPlayer2,
    @required this.result1,
    @required this.result2,
    @required this.date,
    @required this.tournament,
    @required this.round
  });

  final String idPlayer1;
  final String idPlayer2;
  final List<String> result1;
  final List<String> result2;
  final DateTime date;
  final String tournament;
  final String round;

  bool get isFirstWinner {
    return int.parse(result1.last) > int.parse(result2.last);
  }

  String get winnerId {
    return isFirstWinner ? idPlayer1 : idPlayer2;
  }

}
