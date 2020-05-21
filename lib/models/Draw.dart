List<String> rounds = ["Final", "Semifinal", "Cuartos de Final"];

class Draw {
  final Map<String, List<String>> draw;

  Draw(this.draw);

  Map<String, List<String>> getSortedDraw() {
    final nRounds = draw.length;
    final Map<String, List<String>> result = {};
    for (int i = nRounds - 1; i >= 0; i--) {
      result.addAll({
        rounds[i]: draw[rounds[i]],
      });
    }
    return result;
  }
}
