import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';

import 'package:pet_adoption_app/implementations/adoption_impl.dart';
import 'package:pet_adoption_app/models.dart';
import 'package:pet_adoption_app/pages/pet_details_page.dart';
import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/common/app_image.dart';
import 'package:pet_adoption_app/widgets/common/retry_image.dart';

class PetCard extends StatelessWidget {
  const PetCard({
    super.key,
    required this.pet,
  });

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    final bool isAdopted = AdoptionImplementation.isAdopted(pet.id);
    final Color bgColor = isAdopted ? AppColors().body : pet.backgroundColor;
    return Container(
      margin: 12.bottomEdgeInsets,
      child: InkWell(
        onTap: () {
          context.push(PetDetailsPage(pet: pet));
        },
        child: SizedBox(
          width: context.widthPx - 20,
          height: 140,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: 16.edgeInsets,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: 22.borderRadius,
                    color: bgColor.withOpacity(0.3),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pet.name,
                        style: AppStyle().text.h3.copyWith(
                              color: bgColor,
                            ),
                      ),
                      Text(
                        pet.age,
                        style: AppStyle().text.bodySmallBold.copyWith(
                            // color: bgColor,
                            ),
                      ),
                      4.spacing,
                      Text(
                        pet.price.formattedRupeeString,
                        style: AppStyle().text.h4.copyWith(
                              color: bgColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: ColorFiltered(
                  colorFilter: isAdopted
                      ? AppStyle().colorFilters.greyFilter
                      : AppStyle().colorFilters.coloredFilter,
                  child: SizedBox(
                    // width: 50,
                    height: 120,
                    child: Hero(
                      tag: pet.primaryImage,
                      child: AppImage(
                        image: RetryImage(
                          NetworkImage(pet.primaryImage),
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
              if (isAdopted)
                Positioned(
                  bottom: 6,
                  right: 6,
                  child: Container(
                    padding: [2, 16].edgeInsets,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(22),
                        topLeft: Radius.circular(22),
                      ),
                      color: AppColors().body,
                    ),
                    child: Text(
                      "ALREADY ADOPTED",
                      style: AppStyle().text.miniWhiteBold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
