import 'package:flutter/material.dart';
import 'package:tennistournament/widgets/players/players_list.dart';

class RankingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      child: PlayersList(),
    );
  }
}
