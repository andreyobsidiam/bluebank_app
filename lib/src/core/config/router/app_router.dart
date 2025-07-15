import 'dart:async';
import 'package:bluebank_app/gen/assets.gen.dart';
import 'package:bluebank_app/src/core/l10n/l10n.dart';
import 'package:bluebank_app/src/ds/ds.dart';
import 'package:bluebank_app/src/features/auth/presentation/pages/login_page.dart';
import 'package:bluebank_app/src/features/auth/presentation/pages/update_password_page.dart';
import 'package:bluebank_app/src/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:bluebank_app/src/features/auth/presentation/pages/otp_validation_page.dart';
import 'package:bluebank_app/src/features/auth/presentation/pages/password_reset_email_sent_page.dart';
import 'package:bluebank_app/src/features/localization/presentation/pages/language_selection_page.dart';
import 'package:bluebank_app/src/features/post/presentation/pages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String welcomePath = '/welcome';
  static const String postPath = '/home';
  static const String loginPath = '/login';
  static const String forgotPasswordPath = '/forgot-password';
  static const String updatePasswordPath = '/update-password';
  static const String otpValidationPath = '/otp-validation';
  static const String passwordResetEmailSentPath = '/password-reset-email-sent';

  static final router = GoRouter(
    errorBuilder: (context, state) {
      return Scaffold(body: Center(child: Assets.logoBlue.image(height: 100)));
    },
    redirect: (BuildContext context, GoRouterState state) {
      final uri = state.uri;
      if (uri.toString().contains('error_code=otp_expired')) {
        // show a message to the user about OTP expiration
        DsSnackBar.show(
          context: context,
          message: context.l10n.linkExpired,
          icon: Assets.svg.linkOff.svg(height: 24, width: 24),
        );
        return AppRouter.forgotPasswordPath;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: welcomePath,
        builder: (context, state) => const LanguageSelectionPage(),
      ),
      GoRoute(path: postPath, builder: (context, state) => const PostPage()),
      GoRoute(path: loginPath, builder: (context, state) => const LoginPage()),
      GoRoute(
        path: forgotPasswordPath,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: updatePasswordPath,
        builder: (context, state) => const UpdatePasswordPage(),
      ),
      GoRoute(
        path: otpValidationPath,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! Map<String, String> ||
              !extra.containsKey('email') ||
              !extra.containsKey('redirectUrl') ||
              !extra.containsKey('templateId') ||
              !extra.containsKey('subject')) {
            return Scaffold(
              body: Center(child: Text('Invalid OTP parameters.')),
            );
          }
          final email = extra['email']!;
          final redirectUrl = extra['redirectUrl']!;
          final templateId = extra['templateId']!;
          final subject = extra['subject']!;

          return OtpValidationPage(
            email: email,
            redirectUrl: redirectUrl,
            templateId: templateId,
            subject: subject,
          );
        },
      ),
      GoRoute(
        path: passwordResetEmailSentPath,
        builder: (context, state) {
          final extra = state.extra;
          if (extra is! Map<String, String> || !extra.containsKey('email')) {
            return Scaffold(body: Center(child: Text('Invalid parameters.')));
          }
          final email = extra['email']!;
          return PasswordResetEmailSentPage(email: email);
        },
      ),
    ],
    initialLocation: welcomePath,
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
