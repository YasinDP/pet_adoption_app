import 'package:flutter/material.dart';
import 'package:pet_adoption_app/models.dart';

import 'package:pet_adoption_app/utils/ui_utils/styles.dart';

class TimelineSection extends StatelessWidget {
  const TimelineSection(
    this.pet, {
    Key? key,
  }) : super(key: key);
  final Pet pet;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: pet.name,
      child: IgnorePointer(
        ignoringSemantics: false,
        child: Container(
          // alignment: Alignment(0, -1 + fraction * 2),
          padding: EdgeInsets.all(AppStyle().insets.xs),
          decoration: BoxDecoration(
              color: const Color(0xFFE2CFBB),
              borderRadius: BorderRadius.circular(98)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: Opacity(
              opacity: 0.6,
              child: _buildWonderImage(),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildWonderImage() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFF164F2A),
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: const Alignment(0, -.5),
          image: NetworkImage(pet.primaryImage),
        ),
      ),
    );
  }
}
