import 'package:bluebank_app/gen/assets.gen.dart';
import 'package:bluebank_app/src/core/common/utils/context_extensions.dart';
import 'package:bluebank_app/src/core/di/injector.dart';
import 'package:bluebank_app/src/core/l10n/arb/app_localizations.dart';
import 'package:bluebank_app/src/ds/ds.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            passwordResetLinkSent: () {
              context.go(
                '/otp-validation',
                extra: {
                  'email': _emailController.text,
                  'redirectUrl': '/update-password',
                  'templateId': 'yzkq340krw0gd796',
                  'subject': 'Reset Your Password',
                },
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
            child: Center(child: Assets.logo.image(height: 100, width: 100)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: _ForgotPasswordForm(emailController: _emailController),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: Assets.svg.backButton.svg(height: 40, width: 40),
            onPressed: () => context.pop(),
          ),
        ),
      ),
      body: _ForgotPasswordForm(emailController: _emailController),
    );
  }
}

class _ForgotPasswordForm extends StatelessWidget {
  final TextEditingController emailController;

  const _ForgotPasswordForm({required this.emailController});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    l10n.forgotPasswordTitle,
                    style: context.textTheme.displaySmall,
                  ),
                ),
                DsBox.v2xl,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        l10n.enterYourRegisteredEmail,
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colors.primary,
                        ),
                      ),
                      TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: l10n.emailRegisteredInBlueBank,
                        ),
                      ),
                      DsBox.vmd,
                      Text(
                        l10n.weWillSendYouAnEmail,
                        style: context.textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(context.md),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state.maybeWhen(
                loading: () => FilledButton(
                  onPressed: null,
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: context.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                ),
                orElse: () => FilledButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      AuthEvent.resetPassword(email: emailController.text),
                    );
                  },
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: context.md),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    l10n.sendLink,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        DsBox.vmd,
      ],
    );
  }
}
