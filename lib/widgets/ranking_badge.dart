import 'package:flutter/material.dart';
import 'package:tennistournament/utils/constants.dart';

class RankingBadge extends StatelessWidget {
  RankingBadge(this.rank);
  final String rank;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: ACCENT_COLOR,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Text(
        rank,
        style: TextStyle(
          fontSize: 13,
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}
