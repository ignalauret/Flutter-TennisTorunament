import 'package:tennistournament/models/Draw.dart';

Map<String, List<String>> parsePlayers(Map<String, List> players) {
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

Map<String, Draw> parseDraws(Map<String, Map> draws) {
  final Map<String, Draw> result = {};
  draws.values.forEach((map) {
    result.addAll({"A": Draw({})});
    map.forEach((round, list) {
      print(round);
      result["A"].draw.addAll({round: []});
      print(result["A"].draw.keys);
      (list as List).forEach((match) => result["A"].draw[round].add(match));
    });
  });
  return result;
}
