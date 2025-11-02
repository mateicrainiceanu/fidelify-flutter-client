import 'package:fidelify_client/widgets/preference_switch_row.dart';
import 'package:fidelify_client/widgets/titles.dart';
import 'package:flutter/material.dart';

class AppPreferences extends StatefulWidget {
  const AppPreferences({super.key});

  @override
  State<AppPreferences> createState() => _AppPreferencesState();
}

class _AppPreferencesState extends State<AppPreferences> {

  bool _shopOwner = false;

  void _shopOwnerToggle(bool newVal) {
    setState(() {
      _shopOwner = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              value: _shopOwner,
              onChanged: _shopOwnerToggle
          ),

        ],
      )
    );
  }
}