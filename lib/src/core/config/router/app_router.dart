import 'package:go_router/go_router.dart';
import 'package:bluebank_app/src/features/auth/presentation/pages/login_page.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', redirect: (_, __) => '/login'),
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    ],
  );
}
