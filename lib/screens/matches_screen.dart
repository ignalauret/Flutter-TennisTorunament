import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/utils/text_styles.dart';
import 'package:tennistournament/widgets/matches/matches_list.dart';
import 'package:tennistournament/widgets/tournaments/tournaments_list.dart';

class MatchesScreen extends StatefulWidget {
  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  int _selectedIndex = 0;

  DateTime get selectedDay {
    return DateTime.now().subtract(Duration(days: _selectedIndex));
  }

  Widget _buildDayCard(DateTime day, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
          color: _selectedIndex == index ? Colors.black38 : Colors.transparent,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              day.day.toString(),
              style: TextStyle(
                color: _selectedIndex == index ? ACCENT_COLOR : Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat.MMM().format(day),
              style: TextStyle(
                color: _selectedIndex == index ? ACCENT_COLOR : Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
          height: size.height * 0.25 + 50,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 0, bottom: 0),
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
                width: size.width,
                height: 70,
                child: ListView.builder(
                  padding: const EdgeInsets.all(0),
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return _buildDayCard(
                        DateTime.now().subtract(Duration(days: index)), index);
                  },
                ),
              ),
              Container(
                height: 20,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.025),
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "Torneos Activos",
                    style: kMainTitleStyle,
                  ),
                ),
              ),
              Container(
                height: size.height * 0.25 - 40,
                width: double.infinity,
                color: Colors.transparent,
                child: TournamentsList(date: selectedDay,),
              ),
            ],
          ),
        ),
        Expanded(
          child: MatchesList(
            date: DateTime.now().subtract(
              Duration(days: _selectedIndex),
            ),
          ),
        ),
      ],
    );
  }
}
