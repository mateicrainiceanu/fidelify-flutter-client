import 'package:fidelify_client/providers/app_preferences_provider.dart';
import 'package:fidelify_client/widgets/preference_switch_row.dart';
import 'package:fidelify_client/widgets/titles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppPreferences extends StatefulWidget {
  const AppPreferences({super.key});

  @override
  State<AppPreferences> createState() => _AppPreferencesState();
}

class _AppPreferencesState extends State<AppPreferences> {

  @override
  Widget build(BuildContext context) {

    final appPref = context.watch<AppPreferencesProvider>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          const H3Title("App preferences"),

          PreferenceSwitchRow(
              title: "Shop owner",
              value: appPref.isShopOwner,
              onChanged: appPref.setShopOwner
          ),

        ],
      )
    );
  }
}