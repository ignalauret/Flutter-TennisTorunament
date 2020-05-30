import 'package:flutter/material.dart';
import 'package:tennistournament/utils/constants.dart';

class SelectionButtons extends StatelessWidget {
  SelectionButtons(this.labels, this.select, this.selected);
  final String selected;
  final List<String> labels;
  final Function select;

  Widget _buildCategoryButton(
      String text, bool selected, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.30,
      margin: const EdgeInsets.symmetric(vertical: 0),
      child: FlatButton(
        padding: const EdgeInsets.all(15),
        onPressed: () => select(text),
        color: selected ? Colors.black45 : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BORDER_RADIUS),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: TextStyle(
              color: selected ? ACCENT_COLOR : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildCategoryButton(labels[0], labels[0] == selected, context),
        _buildCategoryButton(labels[1], labels[1] == selected, context),
        _buildCategoryButton(labels[2], labels[2] == selected, context),
      ],
    );
  }
}
