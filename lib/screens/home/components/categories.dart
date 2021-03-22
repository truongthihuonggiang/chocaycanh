import 'package:chocaycanh/components/category_card.dart';
import 'package:chocaycanh/model/Cateogies.dart';
import 'package:flutter/material.dart';

class ListCategory extends StatelessWidget {
  const ListCategory({
    Key key,
    this.categories,
  }) : super(key: key);
  final List<Category> categories;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => CategoryCard(category: categories[index]),
        ),
      ),
    );
  }
}
