import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/models/tournament.dart';
import 'package:tennistournament/providers/tournaments.dart';
import 'package:tennistournament/widgets/tournaments/tournaments_list_item.dart';

class TournamentsList extends StatelessWidget {
  TournamentsList({this.date});
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final tournamentsData = Provider.of<Tournaments>(context);
    final List<Tournament> tournaments = tournamentsData.fetchTournaments();
    if (date != null)
      tournaments.removeWhere((tournament) =>
          tournament.start.isAfter(date) || tournament.end.isBefore(date));
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, index) => TournamentsListItem(tournaments[index]),
      itemCount: tournaments.length,
    );
  }
}
