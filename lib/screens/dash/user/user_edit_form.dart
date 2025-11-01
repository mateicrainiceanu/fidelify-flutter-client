import 'package:fidelify_client/screens/dash/user/person_circle_filled.dart';
import 'package:fidelify_client/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_user_provider.dart';

class UserEditForm extends StatefulWidget {
  final VoidCallback? onSubmit;

  const UserEditForm({super.key, this.onSubmit});

  @override
  State<UserEditForm> createState() => _UserEditFormState();
}

class _UserEditFormState extends State<UserEditForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  late String _fname;
  late String _lname;
  late String _phone;
  DateTime? _bdate;

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    _formKey.currentState!.save();
    Log.info(
        "UserEditingFrom._submit(): ${_fname} ${_lname} ${_phone} ${_bdate?.toLocal().toString()}");

    // handle request

    // end handle request

    setState(() {
      _isLoading = false;
    });

    // close popout
    widget.onSubmit?.call();
  }

  void _discard() {}

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthUserProvider>();
    final user = auth.user!;

    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [
              const PersonCircleFilled(),
              TextFormField(
                initialValue: user.fname ?? '',
                decoration: const InputDecoration(labelText: 'First Name'),
                onSaved: (val) => _fname = val ?? '',
              ),
              TextFormField(
                initialValue: user.lname ?? '',
                decoration: const InputDecoration(labelText: 'Last Name'),
                onSaved: (val) => _lname = val ?? '',
              ),
              TextFormField(
                initialValue: user.email,
                decoration: const InputDecoration(labelText: 'Email'),
                readOnly: true,
              ),
              TextFormField(
                initialValue: user.phone ?? '',
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                onSaved: (val) => _phone = val ?? '',
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _bdate != null
                          ? 'Birthdate: ${_bdate!.toLocal().toString().split(' ')[0].split('-').reversed.join('.')}'
                          : 'Birthdate: ${user.bdate != null ? user.bdate!.toLocal().toString().split(' ')[0] : 'Not set'}',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: user.bdate ?? DateTime(2000),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (picked != null) {
                        setState(() => _bdate = picked);
                      }
                    },
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: _submit,
                            child: const Text("Save changes")),
                        OutlinedButton(
                            onPressed: _discard, child: const Text("Discard"))
                      ],
                    )
            ],
          ),
        ),
      ),
    );
  }
}
