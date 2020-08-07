import 'package:flutter/material.dart';
import 'package:tennistournament/widgets/selection_buttons.dart';

class CategoryButtons extends StatelessWidget {
  CategoryButtons(this.selectCategory, this.selectedCategory, this.categories);
  final Function selectCategory;
  final String selectedCategory;
  final List<String> categories;

  void select(String text) {
    selectCategory(text.substring(text.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    return SelectionButtons(categories.map((category) => "Categoría " + category).toList(), select,
        "Categoría " + selectedCategory);
  }
}
