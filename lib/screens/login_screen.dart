
import 'package:fidelify_client/models/auth_user.dart';
import 'package:fidelify_client/providers/api_service.dart';
import 'package:fidelify_client/providers/auth_user_provider.dart';
import 'package:fidelify_client/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/app_localizations.dart';
import '../utils/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen>  createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isRegistering = false;
  var _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit(AppLocalizations l10n) async {
    Log.trace(
        "${_isRegistering ? "Register" : "Login"} : {email: - ${_emailController.text} - password_length: ${_passwordController.text.length}}");

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      Toast.show("Please enter email and password", type: ToastType.error);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final response = await ApiService.instance.post<AuthUser>(
      path: "/api/v1/${_isRegistering ? "register" : "login"}",
      data: {"email": _emailController.text, "password": _passwordController.text},
      parser: AuthUser.fromJson,
    );

    if (!mounted) return;

    if (response.status == NetworkStatus.ok && response.val is AuthUser) {
      final authProvider = Provider.of<AuthUserProvider>(context, listen: false);

      Log.trace("LoginScreen._submit -> Success: ${response.val!.token.substring(0, 10)}");
      
      Toast.show(
          _isRegistering ? l10n.authRegistrationSuccess : l10n.authLoginSuccess,
          type: ToastType.success);

      authProvider.setUser(response.val!);
      Navigator.of(context).pushReplacementNamed("/dash");
      return;
    } else {
      Log.trace("Error: ${response.error?.message ?? "Unknown error"} [${response.error?.code}] [${response.status}]");
      Toast.show(response.error?.message ?? "Something went wrong",
          type: ToastType.error);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
        body: Center(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: Column(
                        key: ValueKey<bool>(_isRegistering),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(_isRegistering ? l10n.authRegister : l10n.authLogin,
                              style: const TextStyle(fontSize: 24.0)),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _emailController,
                            enabled: !_isLoading,
                            decoration: InputDecoration(
                              labelText: l10n.userEmail,
                              prefixIcon: const Icon(Icons.email),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _passwordController,
                            enabled: !_isLoading,
                            decoration: InputDecoration(
                              labelText: l10n.authPassword,
                              prefixIcon: const Icon(Icons.lock),
                            ),
                            obscureText: true,
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : ElevatedButton(
                                    onPressed: () {_submit(l10n);},
                                    child: Text(_isRegistering
                                        ? l10n.authRegister
                                        : l10n.authLogin),
                                  ),
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    setState(() {
                                      _isRegistering = !_isRegistering;
                                    });
                                  },
                            child: Text(_isRegistering
                                ? l10n.authAlreadyHaveAccountLogin
                                : l10n.authDontHaveAccountRegister),
                          )
                        ]
                    ),
                ),
            ),
        ),
    );
  }
}
