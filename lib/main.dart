import 'package:bluebank_app/src/core/config/supabase/supabase_config.dart';
import 'package:bluebank_app/src/core/l10n/arb/app_localizations.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluebank_app/src/features/post/presentation/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bluebank_app/src/core/di/injector.dart';
import 'package:bluebank_app/src/core/config/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
        BlocProvider(create: (context) => getIt<AuthBloc>()),
        BlocProvider(create: (context) => getIt<PostBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Bluebank',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        routerConfig: AppRouter.router,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('en', 'US'),
      ),
    );
  }
}
