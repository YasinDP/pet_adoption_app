import 'package:flutter/material.dart';
import 'package:pet_adoption_app/models.dart';
import 'package:pet_adoption_app/widgets/home/category_card.dart';

class CategoryListView extends StatelessWidget {
  const CategoryListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: Category.count,
        itemBuilder: (context, index) {
          Category category = Category.all[index];
          return CategoryCard(
            category: category,
          );
        },
      ),
    );
  }
}
