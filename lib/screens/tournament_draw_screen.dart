import 'package:flutter/material.dart';
import 'package:tennistournament/models/tournament.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/utils/text_styles.dart';
import 'package:tennistournament/widgets/back_button_app_bar.dart';
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
  String selectedDisplay = "Cuadro";
  bool startingCategory = true;

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

  Widget _buildDisplay(Tournament tournament) {
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
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> argsMap =
        ModalRoute.of(context).settings.arguments;
    if (startingCategory) {
      startingCategory = false;
      selectedCategory = argsMap["selectedCategory"];
    }
    final Tournament tournament = argsMap["tournament"];
    return Scaffold(
      backgroundColor: MAIN_COLOR,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: BackButtonAppBar(
          title: "Cuadro de ${tournament.name}",
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10,),
          CategoryButtons(selectCategory, selectedCategory),
          SizedBox(
            height: 10,
          ),
          SelectionButtons([
            "Jugadores",
            "Cuadro",
            "Partidos",
          ], selectDisplay, selectedDisplay),
          SizedBox(
            height: 10,
          ),
          if (selectedDisplay == "Jugadores")
            Container(
              height: 20,
              padding: const EdgeInsets.only(right: 23, left: 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nombre",
                      style: kSelectionButtonTextStyle,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Jugados",
                      style: kSelectionButtonTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.15,
                    child: Text(
                      "Puntos",
                      style: kSelectionButtonTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          Expanded(
            child: _buildDisplay(tournament),
          ),
        ],
      ),
    );
  }
}
