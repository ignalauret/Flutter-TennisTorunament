import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/models/player.dart';
import '../providers/players.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/search_bar.dart';
import 'package:tennistournament/widgets/selection_buttons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool expanded = false;
  AnimationController _controller;
  String selectedFilter = "Jugadores";
  String searchString = "";

  @override
  void initState() {
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
    });
  }

  Widget _buildPlayerList(String search) {
    return FutureBuilder(
      future: Provider.of<Players>(context, listen: false).fetchPlayers(),
      builder: (context, snapshot) {
        if (snapshot == null || snapshot.data == null)
          return Center(
            child: CircularProgressIndicator(),
          );
        final List<Player> playerList = snapshot.data;
        playerList.retainWhere((player) => player.name.contains(search));
        return (ListView.builder(
          itemBuilder: (context, index) => Card(
            child: Text(playerList[index].name),
          ),
          itemCount: playerList.length,
        ));
      },
    );
  }

  Widget _buildSearch(String search, String selectedFilter) {
    switch (selectedFilter) {
      case "Jugadores":
        return _buildPlayerList(search);
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
                height: 60,
                width: double.infinity,
                color: MAIN_COLOR,
                child: Column(
                  children: <Widget>[
                    SearchBar(expandContainer, collapseContainer, search, searchString),
                  ],
                ),
              ),
              SizeTransition(
                sizeFactor: _controller,
                child: AnimatedContainer(
                  height: size.height * 0.25 + 50 - 20 - 60,
                  width: double.infinity,
                  color: MAIN_COLOR,
                  duration: Duration(milliseconds: 300),
                  child: Column(
                    children: <Widget>[
                      SelectionButtons(["Jugadores", "Partidos", "Torneos"],
                          selectFilter, selectedFilter),
                    ],
                  ),
                ),
              ),
              Container(
                height: 20,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(BORDER_RADIUS),
                    bottomRight: Radius.circular(BORDER_RADIUS),
                  ),
                  color: MAIN_COLOR,
                ),
              )
            ],
          ),
        ),
        if (searchString.isNotEmpty)
          Expanded(
            child: _buildSearch(searchString, selectedFilter),
          )
      ],
    );
  }
}
