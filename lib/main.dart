import 'package:bluebank_app/src/core/config/supabase/supabase_config.dart';
import 'package:bluebank_app/src/core/l10n/arb/app_localizations.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluebank_app/src/features/localization/presentation/bloc/localization_bloc.dart';
import 'package:bluebank_app/src/features/post/presentation/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bluebank_app/src/core/di/injector.dart';
import 'package:bluebank_app/src/core/config/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/ds/ds.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjector();
  await setupSupabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<LocalizationBloc>()
                ..add(const LocalizationEvent.loadLanguage()),
        ),
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<PostBloc>()),
      ],
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
        builder: (context, state) {
          final brightness = View.of(
            context,
          ).platformDispatcher.platformBrightness;

          TextTheme textTheme = createTextTheme(context, "Poppins", "Poppins");
          MaterialTheme theme = MaterialTheme(textTheme);
          return MaterialApp.router(
            title: 'Bluebank',
            theme: brightness == Brightness.light
                ? theme.light()
                : theme.dark(),

            routerConfig: AppRouter.router,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: state.when(
              initial: () => const Locale('en'),
              loaded: (locale) => locale,
            ),
          );
        },
      ),
    );
  }
}
