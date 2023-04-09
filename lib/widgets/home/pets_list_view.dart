import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';
import 'package:pet_adoption_app/models.dart';

import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/home/pet_card.dart';

class PetsListView extends StatelessWidget {
  const PetsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Showing 10 of 22 Pets",
            style: AppStyle().text.smallLabelBold,
          ),
        ),
        16.spacing,
        Expanded(
          child: ListView.builder(
            itemCount: Pet.count,
            itemBuilder: (context, index) {
              Pet pet = Pet.all[index];
              return PetCard(pet: pet);
            },
          ),
        ),
      ],
    );
  }
}
