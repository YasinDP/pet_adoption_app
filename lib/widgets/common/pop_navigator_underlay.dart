import 'package:flutter/material.dart';
import 'package:pet_adoption_app/utils/ui_utils/buttons.dart';

class PopNavigatorUnderlay extends StatelessWidget {
  const PopNavigatorUnderlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: AppBtn.basic(
        onPressed: () => Navigator.of(context).pop(),
        semanticLabel: '',
        child: const SizedBox.expand(),
      ),
    );
  }
}
