import 'package:bluebank_app/src/core/di/injector.dart';
import 'package:bluebank_app/src/core/l10n/arb/app_localizations.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:bluebank_app/src/features/post/presentation/pages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            authenticated: (user) {},
            unauthenticated: () {},
            error: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
          );
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('Bluebank')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(hintText: l10n.emailHint),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(hintText: l10n.passwordHint),
                ),
                const SizedBox(height: 24),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return state.maybeWhen(
                      loading: () => const CircularProgressIndicator(),
                      orElse: () => ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                            AuthEvent.login(
                              email: _emailController.text,
                              password: _passwordController.text,
                            ),
                          );
                        },
                        child: Text(l10n.loginButton),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
