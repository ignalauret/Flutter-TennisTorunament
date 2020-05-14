import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/players.dart';
import 'player_list_item.dart';

class PlayersList extends StatelessWidget {
  PlayersList(this.selectedCategory, this.ranking);
  final String selectedCategory;
  final List<String> ranking;
  @override
  Widget build(BuildContext context) {
    final playersData = Provider.of<Players>(context);
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemBuilder: (ctx, index) => PlayerListItem(
        ranking: (index + 4).toString(),
        name: playersData.getPlayerName(ranking[index]),
        tournaments: "1",
        points: playersData.getPlayerPoints(ranking[index], selectedCategory).toString(),
      ),
      itemCount: ranking.length,
    );
  }
}
