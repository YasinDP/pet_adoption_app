import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pet_adoption_app/models.dart';

import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/success_page/success_details.dart';
import 'package:pet_adoption_app/widgets/success_page/success_intro.dart';

class AdoptionSuccessPage extends StatelessWidget {
  const AdoptionSuccessPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Pet data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RepaintBoundary(
        child: SuccessIntro(
          pet: data,
        ).animate().swap(
              delay: AppStyle().times.fast * 3.5,
              builder: (_, __) => SuccessDetails(
                pet: data,
              ),
            ),
      ),
    );
  }
}
