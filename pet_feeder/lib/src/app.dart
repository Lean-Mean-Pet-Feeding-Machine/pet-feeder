import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'sample_feature/pet_info.dart';
import 'sample_feature/pet_list_view.dart';

import 'settings/settings_view.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet_feeder/thememode.dart';
import 'package:pet_feeder/theme.dart';

import 'data_model/pet_db.dart';

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);

    return MaterialApp(
      theme: lightTheme, // Sets light theme from theme.dart
      darkTheme: darkTheme, // Sets dark theme from theme.dart
      themeMode: _getThemeMode(currentThemeMode),
      // Providing a restorationScopeId allows the Navigator built by the
      // MaterialApp to restore the navigation stack when a user leaves and
      // returns to the app after it has been killed while running in the
      // background.
      restorationScopeId: 'app',

      // Provide the generated AppLocalizations to the MaterialApp. This
      // allows descendant Widgets to display the correct translations
      // depending on the user's locale.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
      ],

      // Use AppLocalizations to configure the correct application title
      // depending on the user's locale.
      //
      // The appTitle is defined in .arb files found in the localization
      // directory.
      onGenerateTitle: (BuildContext context) =>
          AppLocalizations.of(context)!.appTitle,
      onGenerateRoute: (RouteSettings routeSettings) {
        return MaterialPageRoute<void>(
          settings: routeSettings,
          builder: (BuildContext context) {
            switch (routeSettings.name) {
              case SettingsView.routeName:
                return SettingsView();
              case PetInfo.routeName:
                PetData petData = routeSettings.arguments as PetData;
                return PetInfo(pet: petData);
              case PetListPage.routeName:
              default:
                return PetListPage();
            }
          },
        );
      },
    );
  }

  ThemeMode _getThemeMode(ThemeModeOption themeMode) {
    switch (themeMode) {
      case ThemeModeOption.light:
        return ThemeMode.light;
      case ThemeModeOption.dark:
        return ThemeMode.dark;
      case ThemeModeOption.system: //default system theme is dark in flutter
      default:
        return ThemeMode.light;
    }
  }
}
