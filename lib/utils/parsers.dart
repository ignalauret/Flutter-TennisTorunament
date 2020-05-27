import 'package:tennistournament/models/Draw.dart';

Map<String, List<String>> parsePlayers(Map<String, List> players) {
  print(players);
  final Map<String, List<String>> result = {};
  players.forEach(
    (key, list) => result.addAll(
      {key: []},
    ),
  );
  players.forEach((key, list) {
    list.forEach((player) => result[key].add(player));
  });
  return result;
}

List<String> parseResult(String result) {
  return result.split(".");
}

Map<String, Draw> parseDraws(Map<String, List> draws) {
  final Map<String, Draw> result = {};
  draws.forEach((category, matches) {
    result.addAll({category: Draw([])});
    matches.forEach((match) {
      result[category].addMatch(match);
    });
  });
  return result;
}
