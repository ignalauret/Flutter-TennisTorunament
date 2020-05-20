import 'package:flutter/material.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/ranking/ranking_badge.dart';

class DrawMatchCard extends StatelessWidget {
  DrawMatchCard({
    @required this.name1,
    @required this.name2,
    @required this.result1,
    @required this.result2,
    @required this.isFirstWinner,
    @required this.ranking1,
    @required this.ranking2,
  });

  final String ranking1;
  final String ranking2;
  final String name1;
  final String name2;
  final List<String> result1;
  final List<String> result2;
  final bool isFirstWinner;

  Widget _buildPlayerRow(
    String name,
    List<String> result,
    double resultWidth,
    bool winner,
    String ranking,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 130,
          child: Row(
            children: <Widget>[
              RankingBadge(ranking, size: 15,),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(
                width: 10,
              ),
              if (winner)
                Icon(
                  Icons.check,
                  size: 12,
                  color: ACCENT_COLOR,
                ),
            ],
          ),
        ),
        Container(
          width: resultWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: result.map((score) {
              return Container(
                padding: const EdgeInsets.all(5),
                child: Text(
                  score[0],
                  style: TextStyle(
                    color: score.length == 2 ? ACCENT_COLOR : Colors.black,
                    fontSize: 12,
                  ),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _buildPlayerRow(
                  name1, result1, 80, isFirstWinner, ranking1),
              _buildPlayerRow(
                  name2, result2, 80, !isFirstWinner, ranking2),
            ],
          ),
        ));
  }
}
