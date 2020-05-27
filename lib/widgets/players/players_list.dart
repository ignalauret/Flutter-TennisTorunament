import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/providers/ranking.dart';
import 'package:tennistournament/providers/tournaments.dart';
import 'package:tennistournament/screens/player_profile_screen.dart';
import '../../providers/players.dart';
import 'player_list_item.dart';

class PlayersList extends StatelessWidget {
  PlayersList(this.selectedCategory, this.ranking);
  final String selectedCategory;
  final List<String> ranking;
  @override
  Widget build(BuildContext context) {
    final playersData = Provider.of<Players>(context, listen: false);
    final rankingData = Provider.of<Ranking>(context, listen: false);
    final tournamentData = Provider.of<Tournaments>(context, listen: false);
    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemBuilder: (ctx, index) => InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          PlayerProfileScreen.routeName,
          arguments: playersData.getPlayerById(ranking[index]),
        ),
        child: PlayerListItem(
          ranking: rankingData.getRankingOf(ranking[index], selectedCategory),
          name: playersData.getPlayerName(ranking[index]),
          tournaments: tournamentData
              .getPlayersPlayedTournaments(ranking[index], selectedCategory)
              .toString(),
          points: playersData
              .getPlayerPoints(ranking[index], selectedCategory)
              .toString(),
        ),
      ),
      itemCount: ranking.length,
    );
  }
}
