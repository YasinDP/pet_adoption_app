import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/implementations/notifier.dart';
import 'package:pet_adoption_app/theme/theme_manager.dart';
import 'package:pet_adoption_app/utils/helper_utils/app_haptics.dart';
import 'package:pet_adoption_app/utils/ui_utils/colors.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';
import 'package:pet_adoption_app/utils/helper_utils/functions.dart';
import 'package:pet_adoption_app/models.dart';

import 'package:pet_adoption_app/utils/ui_utils/styles.dart';
import 'package:pet_adoption_app/widgets/details_page/blurred_image_bg.dart';
import 'package:pet_adoption_app/widgets/details_page/bottom_text_content.dart';
import 'package:pet_adoption_app/widgets/details_page/collapsing_carousel_item.dart';
import 'package:extra_alignments/extra_alignments.dart';
import 'package:pet_adoption_app/widgets/common/app_header.dart';
import 'package:pet_adoption_app/pages/adoption_success_page.dart';
import 'package:pet_adoption_app/pages/image_viewer_page.dart';
import 'package:pet_adoption_app/widgets/details_page/double_border_image.dart';

class PetCarouselScreen extends ConsumerStatefulWidget {
  const PetCarouselScreen({
    Key? key,
    required this.pet,
  }) : super(key: key);

  final Pet pet;

  @override
  ConsumerState<PetCarouselScreen> createState() => PetDetailScreenState();
}

class PetDetailScreenState extends ConsumerState<PetCarouselScreen> {
  PageController? pageController;
  final currentPage = ValueNotifier<double>(9999);

  late final List<String> images = widget.pet.images;
  late final _currentImageIndex = ValueNotifier<int>(_wrappedPageIndex);

  int get _wrappedPageIndex => currentPage.value.round() % images.length;

  OverflowBox _buildBgCircle(double height) {
    final theme = ref.watch(themeProvider);
    const double size = 2000;
    return OverflowBox(
      maxWidth: size,
      maxHeight: size,
      child: Transform.translate(
        offset: const Offset(0, size / 2),
        child: Container(
          decoration: BoxDecoration(
            color: theme.bgColor,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(size)),
          ),
        ),
      ),
    );
  }

  void _handlePageChanged() {
    currentPage.value = pageController?.page ?? 0;
    _currentImageIndex.value = _wrappedPageIndex;
  }

  void handleAdoptTap() async {
    final screen = AdoptionSuccessPage(
      data: widget.pet,
    );
    showFullscreenDialogRoute(context, screen, transparent: true);
    AppHaptics.mediumImpact();

    // wait to update the state, to ensure the hero works properly:
    await Future.delayed(AppStyle().times.pageTransition);
    final provider = ref.read(appProvider);
    provider.addData(widget.pet.id);
  }

  void handleImageTap(int index) {
    int delta = index - currentPage.value.round();
    if (delta == 0) {
      context.push(ImageViewerPage(
        urls: images,
        index: index % images.length,
      ));
    } else {
      pageController?.animateToPage(
        currentPage.value.round() + delta,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool shortMode = context.heightPx <= 800;
    final double bottomHeight = context.heightPx / 2.75;
    // Allow objects to become wider as the screen becomes tall, this allows
    // them to grow taller as well, filling the available space better.
    double itemHeight = (context.heightPx - 200 - bottomHeight).clamp(250, 400);
    double itemWidth = itemHeight * .666;
    pageController?.dispose();
    pageController = PageController(
      viewportFraction: itemWidth / context.widthPx,
      initialPage: currentPage.value.round(),
    );
    pageController?.addListener(_handlePageChanged);
    final pages = images.map((e) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: DoubleBorderImage(e),
      );
    }).toList();

    return Stack(
      children: [
        /// Blurred Bg
        Positioned.fill(
          child: ValueListenableBuilder<int>(
              valueListenable: _currentImageIndex,
              builder: (_, value, __) {
                return BlurredImageBg(url: images[value]);
              }),
        ),

        /// BgCircle
        _buildBgCircle(bottomHeight),

        /// Carousel Items
        PageView.builder(
          controller: pageController,
          itemBuilder: (_, index) {
            final wrappedIndex = index % pages.length;
            final child = pages[wrappedIndex];
            return ValueListenableBuilder<double>(
              valueListenable: currentPage,
              builder: (_, value, __) {
                final int offset = (value.round() - index).abs();
                return CollapsingCarouselItem(
                  width: itemWidth,
                  indexOffset: min(3, offset),
                  onPressed: () => handleImageTap(index),
                  title: images[wrappedIndex],
                  child: child,
                );
              },
            );
          },
        ),

        /// Bottom Text
        BottomCenter(
          child: ValueListenableBuilder<int>(
            valueListenable: _currentImageIndex,
            builder: (_, value, __) => BottomTextContent(
              pet: widget.pet,
              height: bottomHeight,
              // shortMode: false,
              shortMode: shortMode,
              state: this,
            ),
          ),
        ),

        /// Header
        const AppHeader(
          title: "Pet Details",
          showBackBtn: true,
          isTransparent: true,
        ),
      ],
    );
  }
}
