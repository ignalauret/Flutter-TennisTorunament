String getWinsRatio(int played, int wins) {
  if(played == 0) return "0%";
  if(wins == 0) return "0%";
  final result = wins/played * 100;
  return result.floor().toString() + "%";

}