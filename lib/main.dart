import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennistournament/providers/matches.dart';
import 'package:tennistournament/providers/players.dart';
import 'package:tennistournament/providers/ranking.dart';
import 'package:tennistournament/screens/player_profile_screen.dart';
import 'package:tennistournament/screens/tabs_controller_screen.dart';
import 'package:tennistournament/utils/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Players>(
          create: (_) => Players(),
        ),
        ChangeNotifierProvider<Matches>(
          create: (_) => Matches(),
        ),
        ChangeNotifierProxyProvider<Players, Ranking>(
          create: (ctx) => Ranking(null),
          update: (context, players, prev) => Ranking(players.players),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: MAIN_COLOR,
        ),
        home: TabsControllerScreen(),
        routes: {
          PlayerProfileScreen.routeName : (_) => PlayerProfileScreen(),
        },
      ),
    );
  }
}
