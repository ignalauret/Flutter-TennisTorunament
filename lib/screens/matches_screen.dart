import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tennistournament/utils/constants.dart';
import 'package:tennistournament/widgets/matches/matches_list.dart';

class MatchesScreen extends StatefulWidget {
  @override
  _MatchesScreenState createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  int _selectedIndex = 0;
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
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              DateFormat.MMM().format(day),
              style: TextStyle(
                color: _selectedIndex == index ? ACCENT_COLOR : Colors.white,
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
        Stack(
          children: <Widget>[
            Container(
              height: size.height * 0.25 + 80,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(BORDER_RADIUS),
                  bottomRight: Radius.circular(BORDER_RADIUS),
                ),
                color: MAIN_COLOR,
              ),
            ),
            Positioned(
              top: size.height * 0.25,
              child: Container(
                width: size.width,
                height: 70,
                child: ListView.builder(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    return _buildDayCard(
                        DateTime.now().subtract(Duration(days: index)), index);
                  },
                ),
              ),
            ),
          ],
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
