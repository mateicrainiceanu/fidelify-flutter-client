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

    return Column(children: [
      _isEditing
          ? UserEditForm(onSubmit: () {
              setState(() {
                _isEditing = false;
              });
            })
          : UserDataCard(user),
      if (!_isEditing)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(spacing: 8, children: [
            Expanded(
                child: OutlinedButton(
                    onPressed: toggleEditing,
                    child: const Text("Edit profile"))),
            Expanded(
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonThemes.destructiveBtnStyle,
                    child: const Text("Log out"))),
          ]),
        ),
    ]);
  }
}
