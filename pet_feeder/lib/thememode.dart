import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ThemeModeOption { system, light, dark }

class ThemeModeNotifier extends StateNotifier<ThemeModeOption> {
  ThemeModeNotifier() : super(ThemeModeOption.light);

  void setThemeMode(ThemeModeOption newThemeMode) {
    print('Setting theme mode to: $newThemeMode');
    state = newThemeMode;
  }
}

// Create a provider for storing the current theme mode
final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeModeOption>((ref) {
  return ThemeModeNotifier();
});
