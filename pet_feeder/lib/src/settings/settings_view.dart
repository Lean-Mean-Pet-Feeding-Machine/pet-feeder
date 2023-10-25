import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/thememode.dart';
import 'package:pet_feeder/theme.dart';

class SettingsView extends ConsumerWidget {
  static const routeName = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);
    return Theme(
        data: currentThemeMode == ThemeModeOption.light
            ? lightTheme
            : darkTheme, // Apply appropriate theme based on the currentThemeMode
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButton<ThemeModeOption>(
              value: currentThemeMode,
              onChanged: (newThemeMode) {
                // Update the theme mode using the provider
                ref
                    .read(themeModeProvider.notifier)
                    .setThemeMode(newThemeMode!);
              },
              items: const [
                DropdownMenuItem(
                  value: ThemeModeOption.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeModeOption.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeModeOption.dark,
                  child: Text('Dark Theme'),
                ),
              ],
            ),
          ),
        ));
  }
}
