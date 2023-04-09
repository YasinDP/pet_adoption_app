import 'package:flutter/material.dart';
import 'package:pet_adoption_app/models.dart';

import 'package:pet_adoption_app/widgets/details_page/pet_carousel_screen.dart';

class PetDetailsPage extends StatelessWidget {
  const PetDetailsPage({
    super.key,
    required this.pet,
  });

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PetCarouselScreen(pet: pet),
    );
  }
}
