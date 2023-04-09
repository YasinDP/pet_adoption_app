import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pet_adoption_app/main.dart';
import 'package:pet_adoption_app/widgets/home/pet_card.dart';

class CustomBindings extends AutomatedTestWidgetsFlutterBinding {
  @override
  bool get overrideHttpClient => false;
}

void main() {
  CustomBindings();
  testWidgets('Search and filter pets test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(
      child: MyApp(),
    ));

    // Wait for animations to settle
    await tester.pumpAndSettle();

    // find search field
    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    // enter search query 'keet'
    await tester.enterText(textField, 'keet');
    // verify the input
    expect(find.text('keet'), findsOneWidget);

    // wait for debounce
    await tester.pump(1.seconds);

    // Wait for animations to settle
    await tester.pumpAndSettle();

    // find a pet card
    var petcard = find.byType(PetCard);
    expect(petcard, findsOneWidget);

    // Expect to find a pet item named 'Parakeet'
    expect(find.text('Parakeet'), findsOneWidget);
  });
}
