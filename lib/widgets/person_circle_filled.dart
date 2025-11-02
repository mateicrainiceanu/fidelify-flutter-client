import 'package:flutter/material.dart';

class PersonCircleFilled extends StatelessWidget {
  const PersonCircleFilled({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context)
              .colorScheme
              .primary
              .withValues(alpha: 0.1),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.person,
            size: 40,
          ),
        ),
      ),
    );
  }
}