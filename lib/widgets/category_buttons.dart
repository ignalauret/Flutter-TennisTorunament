import 'package:flutter/material.dart';
import 'package:tennistournament/widgets/selection_buttons.dart';

class CategoryButtons extends StatelessWidget {
  CategoryButtons(this.selectCategory, this.selectedCategory);
  final Function selectCategory;
  final String selectedCategory;

  void select(String text) {
    selectCategory(text.substring(text.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    return SelectionButtons(["Categoria A", "Categoria B", "Categoria C"], select,
        "Categoria " + selectedCategory);
  }
}
