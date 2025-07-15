import 'package:bluebank_app/gen/assets.gen.dart';
import 'package:bluebank_app/src/core/common/utils/context_extensions.dart';
import 'package:bluebank_app/src/core/l10n/l10n.dart';
import 'package:bluebank_app/src/ds/ds.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_event.dart';
import 'package:bluebank_app/src/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OtpValidationPage extends StatefulWidget {
  final String email;
  final String redirectUrl;
  const OtpValidationPage({
    super.key,
    required this.email,
    required this.redirectUrl,
  });

  @override
  State<OtpValidationPage> createState() => _OtpValidationPageState();
}

class _OtpValidationPageState extends State<OtpValidationPage> {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(AuthEvent.sendOtp(email: widget.email));
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _confirmOtp() {
    final l10n = context.l10n;
    final otp = _otpControllers.map((controller) => controller.text).join();
    if (otp.length == 6) {
      context.read<AuthBloc>().add(
        AuthEvent.verifyOtp(email: widget.email, token: otp),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(l10n.completeOtpMessage)));
    }
  }

  void _resendOtp() {
    context.read<AuthBloc>().add(AuthEvent.sendOtp(email: widget.email));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            otpVerified: () {
              context.go(widget.redirectUrl);
            },
            error: (message) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
            otpSent: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(context.l10n.otpSentMessage)),
              );
            },
          );
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 768) {
              return _buildWebLayout();
            } else {
              return _buildMobileLayout();
            }
          },
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
              child: _OtpForm(
                otpControllers: _otpControllers,
                focusNodes: _focusNodes,
                onOtpChanged: _onOtpChanged,
                onConfirm: _confirmOtp,
                onResend: _resendOtp,
              ),
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
      body: _OtpForm(
        otpControllers: _otpControllers,
        focusNodes: _focusNodes,
        onOtpChanged: _onOtpChanged,
        onConfirm: _confirmOtp,
        onResend: _resendOtp,
      ),
    );
  }
}

class _OtpForm extends StatelessWidget {
  final List<TextEditingController> otpControllers;
  final List<FocusNode> focusNodes;
  final void Function(String, int) onOtpChanged;
  final VoidCallback onConfirm;
  final VoidCallback onResend;

  const _OtpForm({
    required this.otpControllers,
    required this.focusNodes,
    required this.onOtpChanged,
    required this.onConfirm,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            DsBox.vlg,
            Text(l10n.otpCodeTitle, style: context.textTheme.displaySmall),
            DsBox.vxxl,
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha((0.10 * 255).toInt()),
                    blurRadius: 50,
                    spreadRadius: 5,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Assets.svg.emailSent.svg(width: 150, height: 150),
            ),
            DsBox.vlg,
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: const TextStyle(fontSize: 16, color: Colors.black),
                children: [
                  TextSpan(
                    text: l10n.otpMessageBold,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colors.primary,
                    ),
                  ),
                  TextSpan(
                    text: l10n.otpMessage.split(l10n.otpMessageBold).last,
                    style: context.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            DsBox.vxxl,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 48,
                  height: 48,
                  child: TextField(
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: otpControllers[index],
                    focusNode: focusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onChanged: (value) => onOtpChanged(value, index),
                  ),
                );
              }),
            ),
            DsBox.v2xl,
            FilledButton(
              onPressed: onConfirm,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                l10n.confirmButton,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            DsBox.vlg,
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: onResend,
              child: Text(
                l10n.resendCodeButton,
                style: context.textTheme.titleLarge,
              ),
            ),
            DsBox.vlg,
          ],
        ),
      ),
    );
  }
}
