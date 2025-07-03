import 'package:bluebank_app/src/core/di/injector.dart';
import 'package:bluebank_app/src/core/l10n/arb/app_localizations.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.when(
            initial: () {},
            loading: () {},
            authenticated: (user) {
              // Navigate to home page
            },
            unauthenticated: () {},
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
            color: const Color(0xFF0077C0),
            child: Center(child: Image.asset('assets/logo.png', height: 100)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: _LoginForm(),
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
              child: Center(child: Image.asset('assets/logo.png', height: 100)),
            ),
            Expanded(
              flex: 8,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: _LoginForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  __LoginFormState createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberWithFaceId = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.goodAfternoon,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: l10n.emailHint),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _passwordController,
            obscureText: !_isPasswordVisible,
            decoration: InputDecoration(
              labelText: l10n.passwordHint,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(l10n.forgotPassword),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.face_outlined),
              const SizedBox(width: 10),
              Text(l10n.rememberWithFaceId),
              const Spacer(),
              Switch(
                value: _rememberWithFaceId,
                onChanged: (value) {
                  setState(() {
                    _rememberWithFaceId = value;
                  });
                },
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
                        email: _emailController.text,
                        password: _passwordController.text,
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
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
