import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tennistournament/screens/home_screen.dart';
import 'package:tennistournament/screens/matches_screen.dart';
import 'package:tennistournament/screens/ranking_screen.dart';
import 'package:tennistournament/utils/constants.dart';

class TabsControllerScreen extends StatefulWidget {
  @override
  _TabsControllerScreenState createState() => _TabsControllerScreenState();
}

class _TabsControllerScreenState extends State<TabsControllerScreen> {
  int _tabIndex = 0;
  final _tabs = [
    HomeScreen(),
    MatchesScreen(),
    RankingScreen(),
    HomeScreen(),
  ];

  final _titles = [
    "Home",
    "Partidos",
    "Ranking",
    "Home"
  ];
  Widget _buildAppBar() {
    return AppBar(
      title: Text(_titles[_tabIndex]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Icons.list,
            size: 30,
            color: MAIN_COLOR,
          ),
          Icon(
            Icons.sort,
            size: 30,
            color: MAIN_COLOR,
          ),
          Icon(
            Icons.compare_arrows,
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
