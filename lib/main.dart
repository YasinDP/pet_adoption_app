import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_adoption_app/pages/home_page.dart';
import 'package:pet_adoption_app/theme/theme_constants.dart';
import 'package:pet_adoption_app/theme/theme_manager.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: kLightTheme,
      darkTheme: kDarkTheme,
      themeMode: theme.themeMode,
      home: const HomePage(),
    );
  }
}
