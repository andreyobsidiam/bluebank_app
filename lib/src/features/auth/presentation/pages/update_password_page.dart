import 'package:bluebank_app/gen/assets.gen.dart' show Assets;
import 'package:bluebank_app/src/core/common/utils/context_extensions.dart';
import 'package:bluebank_app/src/core/l10n/l10n.dart';
import 'package:bluebank_app/src/ds/ds.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _passwordController = TextEditingController();
  final _reenterPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _reenterPasswordController.dispose();
    super.dispose();
  }

  void _updatePassword() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        AuthEvent.updatePassword(password: _passwordController.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: Assets.svg.backButton.svg(height: 40, width: 40),
            onPressed: () {
              try {
                context.pop();
              } catch (_) {
                context.go('/login');
              }
            },
          ),
        ),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            passwordUpdated: () {
              DsSnackBar.show(
                context: context,
                message: context.l10n.passwordChanged,
                icon: Icon(
                  Icons.check_circle_outline,
                  color: context.colors.onPrimary,
                  size: 24,
                ),
              );
              context.go('/login');
            },
            error: (message) {
              DsSnackBar.show(
                context: context,
                message: 'Error updating password: $message',
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                Text('Change Password', style: context.textTheme.displaySmall),
                DsBox.v2xl,
                Text(
                  'Enter the below information',
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'New password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _reenterPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Re-enter new password',
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please re-enter your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const Spacer(),
                FilledButton(
                  onPressed: _updatePassword,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),

                  child: Text(
                    'Change Password',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colors.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
