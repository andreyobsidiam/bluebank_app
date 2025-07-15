import 'dart:async';

import 'package:bluebank_app/src/core/config/supabase/supabase_config.dart';
import 'package:bluebank_app/src/core/common/utils/scaffolds.dart';
import 'package:bluebank_app/src/core/l10n/arb/app_localizations.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluebank_app/src/features/localization/presentation/bloc/localization_bloc.dart';
import 'package:bluebank_app/src/features/post/presentation/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bluebank_app/src/core/di/injector.dart';
import 'package:bluebank_app/src/core/config/router/app_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/ds/ds.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupInjector();
  await setupSupabase();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final StreamSubscription<AuthState> _authStateSubscription;

  @override
  void initState() {
    super.initState();
    _authStateSubscription = Supabase.instance.client.auth.onAuthStateChange.listen(
      (data) {
        final session = data.session;
        // Navega al usuario a la pantalla de login cuando se cierra la sesión
        if (data.event == AuthChangeEvent.signedOut) {
          AppRouter.router.go(AppRouter.loginPath);
        }
        if (data.event == AuthChangeEvent.passwordRecovery) {
          // Redirige al usuario a la pantalla de 'forgot password' si el enlace de recuperación ha expirado
          if (session == null) {
            AppRouter.router.go(AppRouter.forgotPasswordPath);
            return;
          }

          // Redirige al usuario a la pantalla para actualizar la contraseña
          AppRouter.router.go(AppRouter.updatePasswordPath);
        }
      },
      onError: (error) {
        if (error is AuthException && error.statusCode == 'otp_expired') {
          // La excepción de OTP expirado se maneja con la redirección, por lo que no es necesario registrarla.
          return;
        }
      },
    );
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

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
            scaffoldMessengerKey: scaffoldMessengerKey,
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
