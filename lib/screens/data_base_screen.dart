import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/utils/text_styles.dart';

import '../models/player.dart';
import '../models/tournament.dart';
import '../providers/tournaments.dart';
import '../screens/player_profile_screen.dart';
import '../widgets/matches/matches_list.dart';
import '../widgets/tournaments/tournaments_list_item.dart';
import '../providers/players.dart';
import '../utils/constants.dart';
import '../widgets/search_bar.dart';
import '../widgets/selection_buttons.dart';

class DatabaseScreen extends StatefulWidget {
  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> with TickerProviderStateMixin {
  bool expanded = false;
  AnimationController _controller;
  String selectedFilter = "Jugadores";
  String searchString = "";
  String sort = "Más recientes";

  @override
  void initState() {
    Provider.of<Tournaments>(context, listen: false).fetchTournaments();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void selectFilter(String selection) {
    setState(() {
      selectedFilter = selection;
    });
  }

  void selectSort(String selection) {
    setState(() {
      sort = selection;
    });
  }

  void collapseContainer() {
    expanded = false;
    _controller.reverse();
  }

  void expandContainer() {
    expanded = true;
    _controller.forward();
  }

  void search(String search) {
    setState(() {
      searchString = search;
      if (searchString.isEmpty) collapseContainer();
    });
  }

  Widget _buildPlayerList(String search, bool reversed) {
    return FutureBuilder<List<Player>>(
      future: Provider.of<Players>(context, listen: false).fetchPlayers(),
      builder: (context, snapshot) {
        if (snapshot == null || snapshot.data == null)
          return Center(
            child: CircularProgressIndicator(),
          );
        final List<Player> playerList =
            reversed ? snapshot.data.reversed.toList() : snapshot.data;
        if (search.isNotEmpty)
          playerList.retainWhere((player) => player.name.contains(search));
        return ListView.builder(
          itemBuilder: (context, index) => InkWell(
            onTap: () => Navigator.of(context).pushNamed(
                PlayerProfileScreen.routeName,
                arguments: playerList[index]),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  playerList[index].name,
                  style: kPlayerNameStyle,
                ),
              ),
            ),
          ),
          itemCount: playerList.length,
        );
      },
    );
  }

  Widget _buildTournamentsList(String search, bool reversed) {
    return FutureBuilder<List<Tournament>>(
      future: Provider.of<Tournaments>(context).fetchTournaments(),
      builder: (context, snapshot) {
        if (snapshot == null || snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<Tournament> tournamentsList =
            reversed ? snapshot.data.reversed.toList() : snapshot.data;
        if (search.isNotEmpty)
          tournamentsList
              .retainWhere((tournament) => tournament.name.contains(search));
        return ListView.builder(
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(BORDER_RADIUS),
            ),
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(BORDER_RADIUS)),
              child: TournamentsListItem(
                tournamentsList[index],
                color: Colors.white,
                textColor: Colors.black,
              ),
            ),
          ),
          itemCount: tournamentsList.length,
        );
      },
    );
  }

  Widget _buildSearch(String search, String selectedFilter, String sort) {
    switch (selectedFilter) {
      case "Jugadores":
        return _buildPlayerList(search, sort == "Más recientes");
      case "Partidos":
        return MatchesList(
          search: search,
          reversed: sort == "Más recientes",
        );
      case "Torneos":
        return _buildTournamentsList(search, sort == "Más recientes");
    }
  }

  Widget _buildDefault(String selectedFilter) {
    switch (selectedFilter) {
      case "Jugadores":
        return _buildPlayerList("", true);
      case "Partidos":
        return MatchesList();
      case "Torneos":
        return _buildTournamentsList("", true);
    }
  }

  String _buildDefaultTitle(String selectedFilter) {
    switch (selectedFilter) {
      case "Jugadores":
        return "Nuevos jugadores";
      case "Partidos":
        return "Partidos recientes";
      case "Torneos":
        return "Torneos recientes";
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(BORDER_RADIUS),
              bottomRight: Radius.circular(BORDER_RADIUS),
            ),
            color: MAIN_COLOR,
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                width: double.infinity,
                color: MAIN_COLOR,
                child: Column(
                  children: <Widget>[
                    SearchBar(expandContainer, collapseContainer, search,
                        searchString),
                  ],
                ),
              ),
              SizeTransition(
                sizeFactor: _controller,
                child: AnimatedContainer(
                  height: size.height * 0.25 + 50 - 80 - 50,
                  width: double.infinity,
                  color: MAIN_COLOR,
                  duration: Duration(milliseconds: 300),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ordenar por:",
                          style: kMainTitleStyle,
                        ),
                      ),
                      SelectionButtons(
                        ["Más recientes", "Más antiguos"],
                        selectSort,
                        sort,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(BORDER_RADIUS),
                    bottomRight: Radius.circular(BORDER_RADIUS),
                  ),
                  color: MAIN_COLOR,
                ),
                child: SelectionButtons(["Partidos", "Jugadores", "Torneos"],
                    selectFilter, selectedFilter),
              )
            ],
          ),
        ),
        if (searchString.isNotEmpty)
          Expanded(
            child: _buildSearch(searchString, selectedFilter, sort),
          )
        else
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(
                    _buildDefaultTitle(selectedFilter),
                    style: kDarkSubtitleStyle,
                  ),
                ),
                Expanded(child: _buildDefault(selectedFilter)),
              ],
            ),
          ),
      ],
    );
  }
}
