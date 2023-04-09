import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';
import 'package:pet_adoption_app/models.dart';

import 'package:pet_adoption_app/widgets/home/category_card.dart';
import 'package:pet_adoption_app/widgets/home/main_header.dart';
import 'package:pet_adoption_app/widgets/home/pets_list_view.dart';
import 'package:pet_adoption_app/widgets/home/search_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              16.spacing,
              const MainHeader()
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .move(delay: 500.ms),
              16.spacing,
              const SearchField()
                  .animate()
                  .shake(duration: 500.ms)
                  .scaleX(delay: 500.ms),
              16.spacing,
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: Category.count,
                  itemBuilder: (context, index) {
                    Category category = Category.all[index];
                    return CategoryCard(
                      category: category,
                      isSelected: index == 0,
                    );
                  },
                ),
              )
                  .animate()
                  .fadeIn()
                  .move(delay: 300.ms, duration: 600.ms)
                  .scaleY(delay: 500.ms),
              8.spacing,
              Expanded(
                child: const PetsListView()
                    .animate()
                    .fadeIn(duration: 600.ms) // baseline=800ms
                    .slideY(begin: 0.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
