import 'package:flutter/material.dart';

class PreferenceSwitchRow extends StatelessWidget {

  final String title;
  final bool value;
  final Function(bool) onChanged;

  const PreferenceSwitchRow({required this.title, required this.value, required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const Spacer(),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }
}