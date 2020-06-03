import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tennistournament/screens/data_base_screen.dart';
import 'package:tennistournament/screens/matches_screen.dart';
import 'package:tennistournament/screens/ranking_screen.dart';
import 'package:tennistournament/utils/constants.dart';

import '../custom_icons_icons.dart';

class TabsControllerScreen extends StatefulWidget {
  @override
  _TabsControllerScreenState createState() => _TabsControllerScreenState();
}

class _TabsControllerScreenState extends State<TabsControllerScreen> {
  int _tabIndex = 0;
  final _tabs = [
    DatabaseScreen(),
    MatchesScreen(),
    RankingScreen(),
    DatabaseScreen(),
  ];

  final _titles = ["Home", "Calendario", "Ranking", "Base de Datos"];
  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: MAIN_COLOR,
      elevation: 0,
      title: Text(_titles[_tabIndex]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: CurvedNavigationBar(
        height: 45,
        backgroundColor: BACKGROUND_COLOR,
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: MAIN_COLOR,
          ),
          Icon(
            CustomIcons.tennis_calendar,
            size: 30,
            color: MAIN_COLOR,
          ),
          Icon(
            CustomIcons.podium,
            size: 30,
            color: MAIN_COLOR,
          ),
          Icon(
            CustomIcons.tennis_education,
            size: 30,
            color: MAIN_COLOR,
          ),
        ],
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: BACKGROUND_COLOR,
        child: _tabs[_tabIndex],
      ),
    );
  }
}
