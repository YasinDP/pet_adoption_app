import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';
import 'package:pet_adoption_app/models.dart';

import 'package:pet_adoption_app/utils/ui_utils/styles.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.isSelected,
  });

  final Category category;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: 20.rightEdgeInsets,
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            SizedBox(
              width: 55,
              height: 65,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      // alignment: Alignment.bottomCenter,
                      width: 55,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: 16.borderRadius,
                        gradient: isSelected
                            ? AppStyle().gradients.radialGradient
                            : AppStyle().gradients.radialGreyGradient,
                      ),
                    ),
                  ),
                  ColorFiltered(
                    colorFilter: isSelected
                        ? AppStyle().colorFilters.coloredFilter
                        : AppStyle().colorFilters.greyFilter,
                    child: Image.asset(
                      category.image,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                category.name,
                style: AppStyle().text.bodySmallBold,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
