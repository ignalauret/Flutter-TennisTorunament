import 'package:flutter/material.dart';

class Match {
  Match({
    @required this.idPlayer1,
    @required this.idPlayer2,
    @required this.result1,
    @required this.result2,
    @required this.date,
    @required this.tournament,
    @required this.round,
    @required this.category
  });

  final String idPlayer1;
  final String idPlayer2;
  final List<String> result1;
  final List<String> result2;
  final DateTime date;
  final String tournament;
  final String round;
  final String category;

  bool get isFirstWinner {
    return int.parse(result1.last) > int.parse(result2.last);
  }

  String get winnerId {
    return isFirstWinner ? idPlayer1 : idPlayer2;
  }

  List<String> getColouredResult(bool firstPlayer) {
    if(firstPlayer) {
      final result = result1;
      for(int i = 0; i < result.length; i++) {
        if(int.parse(result[i]) > int.parse(result2[i])) result[i] = result[i][0] + " ";
      }
      return result;
    } else {
      final result = result2;
      for(int i = 0; i < result.length; i++) {
        if(int.parse(result[i]) > int.parse(result1[i])) result[i] = result[i][0] + " ";
      }
      return result;
    }
  }

}
