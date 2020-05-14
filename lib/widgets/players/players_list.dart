import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/providers/ranking.dart';
import '../../providers/players.dart';
import 'player_list_item.dart';

class PlayersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ranking = Provider.of<Ranking>(context).fetchRanking();
    final playersData = Provider.of<Players>(context);
    return ListView.builder(
      itemBuilder: (ctx, index) => PlayerListItem(
        ranking: (index + 1).toString(),
        name: playersData.getPlayerName(ranking[index]),
        tournaments: "1",
        points: playersData.getPlayerPoints(ranking[index]).toString(),
      ),
      itemCount: ranking.length,
    );
  }
}
