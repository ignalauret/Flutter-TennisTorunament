import 'dart:math';

import '../utils/constants.dart';
import '../utils/math_methods.dart';

const List<String> Rounds = [
  "Final",
  "Semifinal",
  "Cuartos de Final",
  "Octavos de Final",
  "Primera Ronda",
];

class Draw {
  final List<String> _draw;

  Draw(this._draw);

  /* Getters */

  List<String> get draw {
    return [..._draw];
  }

  int get nRounds {
    return log2(_draw.length).floor() + 1;
  }

  double get drawHeight {
    return pow(2, nRounds - 1) * DRAW_MATCH_HEIGHT;
  }

  String get startingRound {
    return Rounds[nRounds - 1];
  }

  String get actualRound {
    // Find last unplayed match
    final int lastIndex = _draw.lastIndexWhere((match) => match[match.length-1] == ",");
    if(lastIndex == -1) return "Terminado";
    return Rounds[log2(lastIndex + 1).floor()];
  }

  Map<String, List<String>> getSortedDraw() {
    final Map<String, List<String>> temp = {};
    // For each round, add to the map the matches.
    for (int i = 0; i < nRounds; i++) {
      temp.addAll({
        Rounds[i]: [],
      });
      if (i == 0) {
        temp[Rounds[i]].add(_draw[0]);
      } else {
        for (int j = pow(2, i) - 1; j < pow(2, i + 1) - 1; j++) {
          temp[Rounds[i]].add(_draw[j]);
        }
      }
    }
    final Map<String, List<String>> result = {};
    Rounds.sublist(0, nRounds).reversed.forEach(
          (round) => result.addAll({round: temp[round]}),
        );
    return result;
  }

  /* Setters */

  void addMatch(String match) {
    _draw.add(match);
  }

}
