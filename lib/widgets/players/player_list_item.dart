import 'package:flutter/material.dart';
import 'package:tennistournament/utils/constants.dart';

class PlayerListItem extends StatelessWidget {
  PlayerListItem({
    this.name,
    this.ranking,
    this.points,
    this.tournaments,
  });
  final String name;
  final String ranking;
  final String points;
  final String tournaments;

  Widget _buildPlayerStat(String value) {
    return Expanded(
      child: Text(
        value,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 5,
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BORDER_RADIUS)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 20,
              width: 20,
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                color: MAIN_COLOR,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Text(
                ranking,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              alignment: Alignment.centerLeft,
              child: Text(
                name,
                style: PLAYER_NAME_STYLE,
                textAlign: TextAlign.start,
              ),
            ),
            _buildPlayerStat(tournaments),
            _buildPlayerStat(points),
          ],
        ),
      ),
    );
  }
}
