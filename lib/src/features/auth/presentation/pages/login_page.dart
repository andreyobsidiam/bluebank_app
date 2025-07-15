import 'package:bluebank_app/gen/assets.gen.dart';
import 'package:bluebank_app/src/core/common/utils/context_extensions.dart';
import 'package:bluebank_app/src/core/common/utils/time.dart';
import 'package:bluebank_app/src/core/config/router/app_router.dart';
import 'package:bluebank_app/src/core/di/injector.dart';
import 'package:bluebank_app/src/core/l10n/arb/app_localizations.dart';
import 'package:bluebank_app/src/ds/ds.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberWithFaceId = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            authenticated: (user) {
              if (kIsWeb) {
                context.go(
                  '/otp-validation',
                  extra: {
                    'email': _emailController.text,
                    'redirectUrl': AppRouter.homePath,
                    'templateId': 'yzkq340k16xgd796',
                    'subject': 'Your One-Time Password',
                  },
                );
              } else {
                context.push(
                  '/otp-validation',
                  extra: {
                    'email': _emailController.text,
                    'redirectUrl': AppRouter.homePath,
                    'templateId': 'yzkq340k16xgd796',
                    'subject': 'Your One-Time Password',
                  },
                );
              }
            },
            invalidCredentials: () {
              DsSnackBar.show(
                context: context,
                icon: const Icon(Icons.error_outline, color: Colors.red),
                message: AppLocalizations.of(context)!.invalidCredentials,
              );
            },
            error: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
          );
        },
        child: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 768) {
                return _buildWebLayout();
              } else {
                return _buildMobileLayout();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWebLayout() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: const Color(0xFF2A3A8A),
            child: Center(child: Image.asset('assets/logo.png', height: 100)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: _LoginForm(
                emailController: _emailController,
                passwordController: _passwordController,
                isPasswordVisible: _isPasswordVisible,
                rememberWithFaceId: _rememberWithFaceId,
                onPasswordVisibilityChanged: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                onRememberWithFaceIdChanged: (value) {
                  setState(() {
                    _rememberWithFaceId = value;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      color: const Color(0xFF2A3A8A),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(child: Assets.logo.image(height: 100)),
            ),
            Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: _LoginForm(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  isPasswordVisible: _isPasswordVisible,
                  rememberWithFaceId: _rememberWithFaceId,
                  onPasswordVisibilityChanged: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  onRememberWithFaceIdChanged: (value) {
                    setState(() {
                      _rememberWithFaceId = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final bool rememberWithFaceId;
  final VoidCallback onPasswordVisibilityChanged;
  final ValueChanged<bool> onRememberWithFaceIdChanged;

  const _LoginForm({
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.rememberWithFaceId,
    required this.onPasswordVisibilityChanged,
    required this.onRememberWithFaceIdChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final greeting = switch (TimeOfDayHelper.getPeriod(DateTime.now())) {
      'morning' => l10n.goodMorning,
      'afternoon' => l10n.goodAfternoon,
      'evening' => l10n.goodEvening,
      _ => l10n.goodAfternoon,
    };

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            greeting,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: emailController,
            decoration: InputDecoration(labelText: l10n.emailOrLogon),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: passwordController,
            obscureText: !isPasswordVisible,
            decoration: InputDecoration(
              labelText: l10n.passwordHint,
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: onPasswordVisibilityChanged,
              ),
            ),
          ),
          DsBox.vlg,
          Align(
            alignment: Alignment.center,
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // Azul estilo link
              ),
              onPressed: () {
                if (kIsWeb) {
                  context.go('/forgot-password');
                } else {
                  context.push('/forgot-password');
                }
              },
              child: Text(
                l10n.forgotPassword,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Assets.svg.faceId.svg(
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      context.colors.onSurface,
                      BlendMode.srcIn,
                    ),
                  ),
                  DsBox.hlg,
                  Text(
                    l10n.rememberWithFaceId,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Switch(
                value: rememberWithFaceId,
                onChanged: onRememberWithFaceIdChanged,
              ),
            ],
          ),
          const SizedBox(height: 30),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => const Center(child: CircularProgressIndicator()),
                orElse: () => ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      AuthEvent.login(
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFD100),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    l10n.signIn,
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {},
            child: Text(
              l10n.openAccount,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
