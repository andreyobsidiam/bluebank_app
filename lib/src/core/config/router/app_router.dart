import 'dart:async';
import 'package:bluebank_app/src/features/post/presentation/pages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bluebank_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const PostPage()),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    ],
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final bool loggedIn = session != null;
      final bool loggingIn = state.matchedLocation == '/login';

      if (!loggedIn) {
        return '/login';
      }

      if (loggingIn) {
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
