import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/ranking_badge.dart';

class MatchesListItem extends StatelessWidget {
  MatchesListItem({
    @required this.name1,
    @required this.name2,
    @required this.result1,
    @required this.result2,
    @required this.isFirstWinner,
    @required this.round,
    @required this.tournament,
    @required this.date,
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
  final String tournament;
  final String round;
  final DateTime date;

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
          child: Row(
            children: <Widget>[
              RankingBadge(ranking),
              Text(
                name,
                style: PLAYER_NAME_STYLE,
              ),
              SizedBox(
                width: 10,
              ),
              if (winner)
                Icon(
                  Icons.check,
                  size: 20,
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
                padding: const EdgeInsets.all(10),
                child: Text(
                  score[0],
                  style: TextStyle(
                      color: score.length == 2 ? ACCENT_COLOR : Colors.black),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    DateFormat("EE dd MMMM, y").format(date),
                    style: MATCH_INFO_STYLE,
                  ),
                  Text(
                    DateFormat("HH:mm").format(date),
                    style: MATCH_INFO_STYLE,
                  ),
                ],
              ),
              _buildPlayerRow(
                  name1, result1, size.width * 0.3, isFirstWinner, ranking1),
              _buildPlayerRow(
                name2,
                result2,
                size.width * 0.3,
                !isFirstWinner,
                ranking2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    tournament,
                    style: MATCH_INFO_STYLE,
                  ),
                  Text(
                    round,
                    style: MATCH_INFO_STYLE,
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
