import 'package:fidelify_client/screens/dash/user/user_data_card.dart';
import 'package:fidelify_client/screens/dash/user/user_edit_form.dart';
import 'package:fidelify_client/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_user_provider.dart';

class UserDataSection extends StatefulWidget {
  const UserDataSection({super.key});

  @override
  State<UserDataSection> createState() => _UserDataSectionState();
}

class _UserDataSectionState extends State<UserDataSection> {
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthUserProvider>();
    final user = auth.user!;

    void toggleEditing() {
      setState(() {
        _isEditing = !_isEditing;
      });
    }

    void logout() async {
      auth.logout();
      Navigator.of(context).pushNamed("/login");
    }


    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          axisAlignment: -1.0,
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      child: _isEditing
          ? Column(
        key: const ValueKey('edit'),
        children: [
          UserEditForm(
            onSubmit: () => setState(() => _isEditing = false),
          ),
        ],
      )
          : Column(
        key: const ValueKey('view'),
        children: [
          UserDataCard(user),
          Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: toggleEditing,
                    child: const Text("Edit profile"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: logout,
                    style: ButtonThemes.destructiveBtnStyle,
                    child: const Text("Log out"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
