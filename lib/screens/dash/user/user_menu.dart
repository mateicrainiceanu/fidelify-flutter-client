import 'package:fidelify_client/screens/dash/user/app_preferences.dart';
import 'package:fidelify_client/screens/dash/user/user_data_section.dart';
import 'package:flutter/material.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        child: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Card(
                child: Column(
                  children: [
                    UserDataSection(),
                  ],
                )
              ),

              Card(
                  child: Column(
                    children: [
                      AppPreferences(),
                    ],
                  )
              ),

            ],
          ),
        ));
  }
}
