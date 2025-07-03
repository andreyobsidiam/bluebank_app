import 'package:bluebank_app/src/features/localization/presentation/bloc/localization_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 768) {
            return _buildWebLayout(context);
          } else {
            return _buildMobileLayout(context);
          }
        },
      ),
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: const Color(0xFF2C4097),
            child: Center(child: Image.asset('assets/logo.png', height: 100)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: _LanguageSelectionForm(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Container(
      color: const Color(0xFF2C4097),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Center(child: Image.asset('assets/logo.png', height: 80)),
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
                child: _LanguageSelectionForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageSelectionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Choose your language',
            textAlign: TextAlign.center,
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Elige tu lenguaje',
            textAlign: TextAlign.center,
            style: textTheme.titleLarge?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 60),
          _LanguageOption(
            svgAsset: 'assets/svg/flag_kindom.svg',
            language: 'English',
            onTap: () {
              context.read<LocalizationBloc>().add(
                const LocalizationEvent.changeLanguage('en'),
              );
              context.go('/login');
            },
          ),
          const SizedBox(height: 24),
          _LanguageOption(
            svgAsset: 'assets/svg/flag_spain.svg',
            language: 'Español',
            onTap: () {
              context.read<LocalizationBloc>().add(
                const LocalizationEvent.changeLanguage('es'),
              );
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String svgAsset;
  final String language;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.svgAsset,
    required this.language,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey[200],
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: Row(
        children: [
          SvgPicture.asset(svgAsset, height: 32, width: 32),
          const SizedBox(width: 24),
          Expanded(
            child: Text(
              language,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16),
        ],
      ),
    );
  }
}
