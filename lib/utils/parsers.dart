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

// Example: 25/5/2020
DateTime parseDate(String date) {
  final list = date.split("/");
  return DateTime(
    int.parse(list[2]),
    int.parse(list[1]),
    int.parse(list[0]),
  );
}

// Example: 25/5/2020/18/30
DateTime parseDateWithHour(String date) {
  final list = date.split("/");
  return DateTime(
    int.parse(list[2]),
    int.parse(list[1]),
    int.parse(list[0]),
    int.parse(list[3]),
    int.parse(list[4]),
  );
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
