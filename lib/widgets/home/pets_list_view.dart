import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/implementations/notifier.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';
import 'package:pet_adoption_app/models.dart';

import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/common/app_loading_indicator.dart';
import 'package:pet_adoption_app/widgets/home/pet_card.dart';

class PetsListView extends ConsumerStatefulWidget {
  const PetsListView({
    super.key,
  });

  @override
  ConsumerState<PetsListView> createState() => _PetsListViewState();
}

class _PetsListViewState extends ConsumerState<PetsListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    final provider = ref.watch(appProvider);
    Future.delayed(
      Duration.zero,
      () => provider.search(),
    );
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !provider.refreshing &&
          !provider.allLoaded) {
        updatePets();
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void updatePets() {
    final provider = ref.watch(appProvider);
    provider.updatePets();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(appProvider);
    List<Pet> pets = provider.paginatedPets;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Showing ${pets.length} of ${Pet.count} Pets",
            style: AppStyle().text.smallLabelBold,
          ),
        ),
        16.spacing,
        Expanded(
          child: pets.isEmpty
              ? const Center(
                  child: AppLoadingIndicator(),
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: Pet.count,
                  itemBuilder: (context, index) {
                    Pet pet = Pet.all[index];
                    return PetCard(pet: pet);
                  },
                ),
        ),
        if (provider.refreshing && !provider.allLoaded)
          const AppLoadingIndicator(),
      ],
    );
  }
}
