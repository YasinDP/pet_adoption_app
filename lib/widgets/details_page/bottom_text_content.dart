import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:pet_adoption_app/implementations/notifier.dart';
import 'package:pet_adoption_app/theme/theme_manager.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';
import 'package:pet_adoption_app/utils/ui_utils/buttons.dart';
import 'package:pet_adoption_app/models.dart';

import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/details_page/app_page_indicator.dart';
import 'package:pet_adoption_app/widgets/details_page/pet_carousel_screen.dart';
import 'package:pet_adoption_app/widgets/common/static_text_scale.dart';
import 'package:pet_adoption_app/widgets/success_page/animated_ribbon.dart';

class BottomTextContent extends ConsumerWidget {
  const BottomTextContent(
      {Key? key,
      required this.pet,
      required this.height,
      required this.state,
      required this.shortMode})
      : super(key: key);

  final Pet pet;
  final double height;
  final PetDetailScreenState state;
  final bool shortMode;
  int get _currentPage => state.currentPage.value.round();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(appProvider);
    final theme = ref.watch(themeProvider);
    bool isAdopted = provider.isAdopted(pet.id);
    return Container(
      width: AppStyle().sizes.maxContentWidth2,
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: AppStyle().insets.md,
      ),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  IgnorePointer(
                    ignoringSemantics: false,
                    child: Semantics(
                      button: true,
                      onIncrease: () => state.handleImageTap(_currentPage + 1),
                      onDecrease: () => state.handleImageTap(_currentPage - 1),
                      onTap: () => state.handleImageTap(_currentPage),
                      liveRegion: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Force column to stretch horizontally so text is centered
                          const SizedBox(width: double.infinity),
                          // Stop text from scaling to make layout a little easier, it's already quite large
                          StaticTextScale(
                            child: Text(
                              pet.name,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyle().text.h2.copyWith(
                                  color: theme.iconColor,
                                  height: 1.2,
                                  fontSize: 32),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                          ),

                          Gap(AppStyle().insets.xxs),
                          Text(
                            pet.age.isEmpty ? '--' : pet.age,
                            style: AppStyle().text.body,
                            textAlign: TextAlign.center,
                          ),

                          Gap(AppStyle().insets.xxs),
                          Text(
                            pet.price.formattedRupeeString,
                            style: AppStyle().text.h2.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: theme.iconColor,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ).animate(key: ValueKey(pet.id)).fadeIn(),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              AppPageIndicator(
                count: state.images.length,
                controller: state.pageController!,
                semanticPageTitle: "Pet Details",
              ),
              Gap(AppStyle().insets.md),
              isAdopted
                  ? const AnimatedRibbon("You have already adopted this pet")
                  : AppBtn.from(
                      text: "Adopt Me",
                      expand: true,
                      onPressed: state.handleAdoptTap,
                    ),
              Gap(AppStyle().insets.lg),
            ],
          ),
        ],
      ),
    );
  }
}
