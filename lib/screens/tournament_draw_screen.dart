import 'package:flutter/material.dart';
import 'package:tennistournament/models/tournament.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/category_buttons.dart';
import 'package:tennistournament/widgets/matches/matches_list.dart';
import 'package:tennistournament/widgets/players/players_list.dart';
import 'package:tennistournament/widgets/selection_buttons.dart';
import 'package:tennistournament/widgets/tournament_draw.dart';

class TournamentDrawScreen extends StatefulWidget {
  static const routeName = "/tournament-draw";
  @override
  _TournamentDrawScreenState createState() => _TournamentDrawScreenState();
}

class _TournamentDrawScreenState extends State<TournamentDrawScreen> {
  String selectedCategory = "A";
  String selectedDisplay = "Jugadores";

  void selectCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  void selectDisplay(String display) {
    setState(() {
      selectedDisplay = display;
    });
  }

  Widget _buildDiplay(Tournament tournament) {
    switch (selectedDisplay) {
      case "Jugadores":
        return PlayersList(
            selectedCategory, tournament.players[selectedCategory]);
      case "Cuadro":
        return TournamentDraw(tournament, selectedCategory);
      case "Partidos":
        return MatchesList(
          tournamentId: tournament.id,
          selectedCategory: selectedCategory,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Tournament tournament = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: MAIN_COLOR,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: size.height * 0.05,
                width: size.width,
                margin: const EdgeInsets.only(top: 30, bottom: 10),
              ),
              Positioned(
                top: size.height * 0.03,
                left: size.width * 0.03,
                width: 80,
                child: FlatButton(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, right: 10, left: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.arrow_back,
                        color: ACCENT_COLOR,
                        size: 20,
                      ),
                      Text(
                        "Volver",
                        style: BUTTON_STYLE,
                      ),
                    ],
                  ),
                  color: Colors.black45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(BORDER_RADIUS),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
          CategoryButtons(selectCategory, selectedCategory),
          SelectionButtons([
            "Jugadores",
            "Cuadro",
            "Partidos",
          ], selectDisplay, selectedDisplay),
          Expanded(
            child: _buildDiplay(tournament),
          ),
        ],
      ),
    );
  }
}
