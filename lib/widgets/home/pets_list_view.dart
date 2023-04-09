import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/implementations/notifier.dart';
import 'package:pet_adoption_app/theme/theme_manager.dart';
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

  late bool init;

  @override
  void initState() {
    init = true;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final provider = ref.watch(appProvider);
    if (init) {
      Future.delayed(
        Duration.zero,
        () => provider.search(),
      );
      provider.fetchData();
      init = false;
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !provider.refreshing &&
          !provider.loading &&
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
    final theme = ref.watch(themeProvider);
    List<Pet> pets = provider.paginatedPets;
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Showing ${pets.length} of ${provider.availablePets} Pets",
            style: AppStyle().text.smallBold.copyWith(
                  color: theme.labelColor,
                ),
          ),
        ),
        16.spacing,
        Expanded(
          child: provider.refreshing
              ? const Center(
                  child: AppLoadingIndicator(),
                )
              : pets.isEmpty
                  ? Column(
                      children: [
                        24.spacing,
                        Padding(
                          padding: 36.edgeInsets,
                          child: Text(
                            "No pets are available with selected filters. Pls try with a different category or search query.",
                            textAlign: TextAlign.center,
                            style: AppStyle().text.largeFont.copyWith(
                                  color: theme.labelColor,
                                ),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: pets.length,
                      itemBuilder: (context, index) => PetCard(
                        pet: pets[index],
                      ),
                    ),
        ),
        if (provider.loading && !provider.allLoaded)
          const Center(child: AppLoadingIndicator()),
      ],
    );
  }
}
