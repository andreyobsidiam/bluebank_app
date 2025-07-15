import 'dart:async';

import 'package:bluebank_app/gen/assets.gen.dart' show Assets;
import 'package:bluebank_app/src/core/common/utils/context_extensions.dart';
import 'package:bluebank_app/src/core/l10n/l10n.dart';
import 'package:bluebank_app/src/ds/ds.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_event.dart'
    show AuthEvent;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PasswordResetEmailSentPage extends StatefulWidget {
  const PasswordResetEmailSentPage({super.key, required this.email});

  final String email;

  @override
  State<PasswordResetEmailSentPage> createState() =>
      _PasswordResetEmailSentPageState();
}

class _PasswordResetEmailSentPageState
    extends State<PasswordResetEmailSentPage> {
  Timer? _timer;
  int _start = 60;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_start == 1) {
        setState(() {
          timer.cancel();
          _canResend = true;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void _resendInstructions() {
    if (_canResend) {
      context.read<AuthBloc>().add(
        AuthEvent.resetPassword(email: widget.email),
      );
      setState(() {
        _start = 60;
        _canResend = false;
      });
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
                context.go('/forgot-password');
              }
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.instructionsEmailTitle,
                      style: context.textTheme.headlineMedium?.copyWith(),
                    ),
                    DsBox.vxl,
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(
                                (0.15 * 255).toInt(),
                              ),
                              blurRadius: 50,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Assets.svg.emailSent.svg(height: 150),
                      ),
                    ),
                    DsBox.vxl,
                    Text(
                      l10n.instructionsSentTo,
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: context.colors.primary,
                      ),
                    ),
                    DsBox.vmd,
                    Text(widget.email, style: context.textTheme.titleLarge),
                    DsBox.vxl,
                    Text(
                      l10n.instructionsToChangePassword,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyLarge,
                    ),
                    DsBox.v2xl,
                  ],
                ),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: context.md),
              ),
              onPressed: _canResend ? _resendInstructions : null,
              child: Text(
                _canResend
                    ? l10n.resendInstructions
                    : l10n.resendInstructionsIn(_start.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
