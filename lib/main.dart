import 'package:bluebank_app/src/core/l10n/arb/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:bluebank_app/src/core/di/injector.dart';
import 'package:bluebank_app/src/core/config/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Bluebank',
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: AppRouter.router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('en', 'US'),
    );
  }
}
