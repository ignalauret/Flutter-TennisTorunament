import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/match.dart';
import '../providers/ranking.dart';
import '../providers/tournaments.dart';
import '../utils/constants.dart';
import '../utils/text_styles.dart';
import '../widgets/head_to_head.dart';
import '../widgets/matches/matches_list.dart';
import '../widgets/matches/matches_list_item.dart';
import '../widgets/tennis_back_button.dart';
import '../providers/players.dart';

class MatchDetailScreen extends StatelessWidget {
  static const routeName = "/h2h";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Match match = ModalRoute.of(context).settings.arguments;

    final playerData = Provider.of<Players>(context, listen: false);
    final ranking = Provider.of<Ranking>(context, listen: false);
    final tournamentData = Provider.of<Tournaments>(context, listen: false);
    return Scaffold(
      backgroundColor: MAIN_COLOR,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: size.height * 0.57 - AppBar().preferredSize.height,
            pinned: true,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TennisBackButton(),
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Stack(
                children: <Widget>[
                  Container(
                    height: size.height * 0.52,
                    width: size.width,
                    child: Image.asset(
                      match.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.5,
                    child: Container(
                      height: size.height * 0.03,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: MAIN_COLOR,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(BORDER_RADIUS),
                          topRight: Radius.circular(BORDER_RADIUS),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  child: Column(
                    children: <Widget>[
                      MatchesListItem(
                        name1: playerData.getPlayerName(match.idPlayer1),
                        name2: playerData.getPlayerName(match.idPlayer2),
                        result1: match.result1,
                        result2: match.result2,
                        round: match.round,
                        ranking1: ranking.getRankingOf(
                            match.idPlayer1, match.category),
                        ranking2: ranking.getRankingOf(
                            match.idPlayer2, match.category),
                        date: match.date,
                        tournament:
                            tournamentData.getTournamentName(match.tournament) +
                                " " +
                                match.category,
                        isFirstWinner: match.isFirstWinner,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Head to Head",
                        style: kMainTitleStyle,
                      ),
                      HeadToHead(
                        playerData.getPlayerById(match.idPlayer1),
                        playerData.getPlayerById(match.idPlayer2),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Otros partidos",
                        style: kMainTitleStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: MatchesList(
                          playerId: match.idPlayer1,
                          playerId2: match.idPlayer2,
                          dontShowMatch: match.id,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
