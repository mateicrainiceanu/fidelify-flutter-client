import 'package:fidelify_client/providers/app_preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dash.dart';

class ProviderDash extends StatelessWidget {

  const ProviderDash({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppPreferencesProvider(),
      child: const Dash(),
    );
  }
}