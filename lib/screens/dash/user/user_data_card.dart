import 'package:fidelify_client/l10n/app_localizations.dart';
import 'package:fidelify_client/models/auth_user.dart';
import 'package:fidelify_client/screens/dash/user/person_circle_filled.dart';
import 'package:flutter/material.dart';

class UserDataCard extends StatelessWidget {
  final AUser _user;

  const UserDataCard(this._user, {super.key});

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
          padding: const EdgeInsetsGeometry.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_user.fname ?? "${l10n.userFname}: -"),
                  Text(_user.lname ?? "${l10n.userLname}: -"),
                  Text(_user.email),
                  Text(_user.phone ?? "${l10n.userPhone}: -"),
                  Text(_user.bdate?.toString() ?? "${l10n.userBdate}: -"),
                ],
              ),
              const Spacer(),
              const PersonCircleFilled()
            ],
          ),
      ),
    );
  }
}