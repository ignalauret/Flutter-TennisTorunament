import 'dart:math' as math;

import 'package:tennistournament/models/Draw.dart';
import 'package:tennistournament/utils/constants.dart';

double log2(num x) => math.log(x)/math.log(2);

double getMargin(Draw draw, int roundLength) {
  final int rounds = draw.draw.length;
  final int thisRound = log2(roundLength).ceil();
  final result = rounds - thisRound - 1;
  if(result == 0) return 0;
  if(result == 1) return DRAW_MATCH_HEIGHT/2;
  return (result - 1) * DRAW_MATCH_HEIGHT + DRAW_MATCH_HEIGHT/2;
}