import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/models/tournament.dart';
import 'package:tennistournament/providers/tournaments.dart';
import 'package:tennistournament/utils/text_styles.dart';
import 'package:tennistournament/widgets/tournaments/tournaments_list_item.dart';

class TournamentsList extends StatelessWidget {
  TournamentsList({this.date});
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final tournamentsData = Provider.of<Tournaments>(context, listen: false);
    return FutureBuilder(
      future: tournamentsData.fetchTournaments(),
      builder: (ctx, snapshot) {
        if (snapshot == null || snapshot.data == null)
          return Center(child: CircularProgressIndicator());
        final List<Tournament> tournaments = snapshot.data;
        if (date != null)
          tournaments.removeWhere((tournament) =>
              tournament.start.isAfter(date) || tournament.end.isBefore(date));
        return tournaments.length == 0
            ? Center(
                child: Text(
                  "No hay torneos activos en esta fecha",
                  style: kSmallTitleStyle,
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) =>
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TournamentsListItem(tournaments[index]),
                    ),
                itemCount: tournaments.length,
              );
      },
    );
  }
}
