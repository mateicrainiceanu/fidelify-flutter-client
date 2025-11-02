import 'package:fidelify_client/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SimpleLoadingScreen extends StatelessWidget {

  const SimpleLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            const CircularProgressIndicator(),
            Text(l10n.loading)
          ]
        ),
      ),
    );
  }
}