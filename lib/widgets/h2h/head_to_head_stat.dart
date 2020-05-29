import 'package:flutter/material.dart';
import 'package:tennistournament/utils/constants.dart';

class HeadToHeadStat extends StatelessWidget {
  HeadToHeadStat(this.label, this.value1, this.value2, this.withStatBar);
  final String label;
  final String value1;
  final String value2;
  final bool withStatBar;

  Widget _buildStatBar(
      double percentage, Color color, bool leftAligned, double screenWidth) {
    final double totalWidth = screenWidth * 0.5 - 25;
    final double coloredWith = totalWidth * percentage;
    return Stack(
      children: <Widget>[
        Container(
          height: 6,
          width: totalWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.black45,
          ),
        ),
        Positioned(
          left: leftAligned ? 0 : null,
          right: leftAligned ? null : 0,
          child: Container(
            height: 6,
            width: coloredWith,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: color,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextStyle valuesStyle = TextStyle(color: Colors.white, fontSize: 16);
    int number1;
    int number2;
    if (withStatBar) {
      number1 = int.parse(value1);
      number2 = int.parse(value2);
    }
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 20,
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      value1.toString(),
                      style: valuesStyle,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  label,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              Expanded(
                child: Container(
                  height: 20,
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      value2.toString(),
                      style: valuesStyle,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (withStatBar)
            SizedBox(
              height: 5,
            ),
          if (withStatBar)
            Row(
              children: <Widget>[
                Expanded(
                  child: _buildStatBar(
                      number1 == 0 ? 0 : number1 / (number1 + number2),
                      number1 > number2
                          ? ACCENT_COLOR
                          : ACCENT_COLOR.withAlpha(120),
                      false,
                      size.width),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: _buildStatBar(
                      number2 == 0 ? 0 : number2 / (number1 + number2),
                      number1 < number2
                          ? ACCENT_COLOR
                          : ACCENT_COLOR.withAlpha(120),
                      true,
                      size.width),
                ),
              ],
            )
        ],
      ),
    );
  }
}