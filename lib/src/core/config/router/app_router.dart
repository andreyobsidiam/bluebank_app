import 'dart:async';
import 'package:bluebank_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:bluebank_app/src/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:bluebank_app/src/features/localization/presentation/pages/language_selection_page.dart';
import 'package:bluebank_app/src/features/post/presentation/pages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const LanguageSelectionPage(),
      ),
      GoRoute(path: '/', builder: (context, state) => const PostPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
    ],
    initialLocation: '/welcome',
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final bool loggedIn = session != null;
      final bool onAuthFlow =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/welcome' ||
          state.matchedLocation == '/forgot-password';

      if (!loggedIn) {
        return onAuthFlow ? null : '/welcome';
      }

      if (onAuthFlow) {
        return '/';
      }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(
      Supabase.instance.client.auth.onAuthStateChange,
    ),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
