import 'package:fidelify_client/providers/api_service.dart';
import 'package:fidelify_client/screens/dash/user/person_circle_filled.dart';
import 'package:fidelify_client/utils/logger.dart';
import 'package:fidelify_client/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/auth_user.dart';
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
  late String _email;
  DateTime? _bdate;

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    _formKey.currentState!.save();
    Log.info(
        "UserEditingFrom._submit(): $_fname $_lname $_phone ${_bdate?.toLocal().toString()}");

    // handle request

    final response = await ApiService.instance.put<AuthUser>(path: "/api/v1/user", data: {
      "fname": _fname,
      "lname": _lname,
      "phone": _phone,
      "email": _email,
      "bdate": _bdate?.toLocal().toString()
    }, parser: AuthUser.fromJson);


    if (!mounted) return;

    if (response.status == NetworkStatus.error) {
      Toast.error("${response.error?.message ?? "Unknown error"} [${response.error?.code}]");
      setState(() {
        _isLoading = false;
      });
    } else {
      final authProvider = Provider.of<AuthUserProvider>(context, listen: false);

      Log.trace("UserEditForm._submit -> Success: ${response.val!.token.substring(0, 10)}");

      Toast.success("Success");

      authProvider.setUser(response.val!);

    }

    // end handle request

    setState(() {
      _isLoading = false;
    });

    // close popout
    widget.onSubmit?.call();
  }

  void _discard() {
    widget.onSubmit?.call();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthUserProvider>();
    final user = auth.user!;

    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
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
                validator: (em) => em == null || em.isEmpty || !em.contains('@') || !em.contains('.')
                    ? 'A valid email is required'
                    : null,
                onSaved: (val) => _email = val ?? '',

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
    );
  }
}
