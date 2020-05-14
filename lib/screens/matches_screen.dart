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
      child: Card(
        color: Colors.transparent,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BORDER_RADIUS)),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(BORDER_RADIUS),
            color: _selectedIndex == index ? MAIN_COLOR : Colors.white,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                day.day.toString(),
                style: TextStyle(
                    color:
                        _selectedIndex == index ? Colors.white : ACCENT_COLOR),
              ),
              Text(
                DateFormat.MMM().format(day),
                style: TextStyle(
                    color:
                        _selectedIndex == index ? Colors.white : ACCENT_COLOR),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
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
