import 'package:flutter/material.dart';
import 'package:pet_adoption_app/widgets/timeline/timeline_screen.dart';

class AdoptionHistoryPage extends StatelessWidget {
  const AdoptionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: TimelineScreen());
  }
}
