import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/helper_utils/app_haptics.dart';
import 'package:pet_adoption_app/utils/helper_utils/extensions.dart';
import 'package:pet_adoption_app/widgets/common/app_header.dart';
import 'package:pet_adoption_app/widgets/common/app_image.dart';

class ImageViewerPage extends StatefulWidget {
  const ImageViewerPage({
    Key? key,
    required this.urls,
    this.index = 0,
  }) : super(key: key);
  final List<String> urls;
  final int index;

  static const double imageScale = 2.5;

  @override
  State<ImageViewerPage> createState() => _ImageViewerPageState();
}

class _ImageViewerPageState extends State<ImageViewerPage> {
  final _isZoomed = ValueNotifier(false);
  late final _controller = PageController(initialPage: widget.index);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleBackPressed() =>
      Navigator.pop(context, _controller.page!.round());

  @override
  Widget build(BuildContext context) {
    Widget content = AnimatedBuilder(
      animation: _isZoomed,
      builder: (_, __) {
        final bool enableSwipe = !_isZoomed.value && widget.urls.length > 1;
        return PageView.builder(
          physics: enableSwipe
              ? const PageScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          controller: _controller,
          itemCount: widget.urls.length,
          itemBuilder: (_, index) => _Viewer(widget.urls[index], _isZoomed),
          onPageChanged: (_) => AppHaptics.lightImpact(),
        );
      },
    );

    content = Semantics(
      container: true,
      image: true,
      child: ExcludeSemantics(child: content),
    );

    return Scaffold(
      body: SizedBox(
        height: context.heightPx,
        width: context.widthPx,
        child: Stack(
          children: [
            Positioned.fill(child: content),
            AppHeader(onBack: _handleBackPressed, isTransparent: true),
          ],
        ),
      ),
    );
  }
}

class _Viewer extends StatefulWidget {
  const _Viewer(this.url, this.isZoomed, {Key? key}) : super(key: key);

  final String url;
  final ValueNotifier<bool> isZoomed;

  @override
  State<_Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<_Viewer> with SingleTickerProviderStateMixin {
  final _controller = TransformationController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      transformationController: _controller,
      onInteractionEnd: (_) =>
          widget.isZoomed.value = _controller.value.getMaxScaleOnAxis() > 1,
      minScale: 1,
      maxScale: 5,
      child: Hero(
        tag: widget.url,
        child: AppImage(
          image: NetworkImage(
            widget.url,
          ),
          fit: BoxFit.contain,
          scale: ImageViewerPage.imageScale,
          progress: true,
        ),
      ),
    );
  }
}
