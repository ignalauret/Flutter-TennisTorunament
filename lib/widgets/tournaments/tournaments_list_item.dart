import 'package:flutter/material.dart';
import 'package:tennistournament/models/tournament.dart';
import 'package:tennistournament/screens/tournament_detail_screen.dart';
import 'package:tennistournament/utils/constants.dart';

class TournamentsListItem extends StatelessWidget {
  Widget _buildInfo(IconData icon, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: ACCENT_COLOR,
          size: 15,
        ),
        SizedBox(
          width: 5,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  TournamentsListItem(this.tournament,
      {this.color = Colors.black45, this.textColor = Colors.white});
  final Tournament tournament;
  final Color color;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(TournamentDetailScreen.routeName, arguments: tournament);
      },
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
          color: color,
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 60,
              margin: const EdgeInsets.only(right: 10),
              child: Image.network(tournament.logoUrl),
            ),
            Container(
              width: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      tournament.name,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  _buildInfo(
                    Icons.home,
                    tournament.club,
                  ),
                  _buildInfo(
                    Icons.people,
                    tournament.getInitialPlayers().toString() + " inscriptos",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
