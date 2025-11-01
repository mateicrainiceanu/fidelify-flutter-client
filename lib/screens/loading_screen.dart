import 'package:fidelify_client/l10n/app_localizations.dart';
import 'package:fidelify_client/providers/auth_user_provider.dart';
import 'package:fidelify_client/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _retryAvailable = false;

  @override
  void initState() {
    super.initState();
    initialiseUserData();
  }

  Future<void> initialiseUserData() async {
    _retryAvailable = false;
    final auth = Provider.of<AuthUserProvider>(context, listen: false);

    // Initialize user data
    await auth.init();

    if (!mounted) { return; }
    // Navigate to appropriate screen

    if (auth.cannotConnect) {
      Toast.show("Cannot connect to server", type: ToastType.error);
      _retryAvailable = true;
      return;
    }

    if (auth.isLoggedIn == true) {
      Navigator.of(context).pushNamed("/dash");
    } else if (auth.isLoggedIn == false) {
      Navigator.of(context).pushNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {

    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: _retryAvailable
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 20,
                children: [
                  const Text("Fidelify", style: TextStyle(fontSize: 24),),
                  Text(l10n.anErrorOcc),
                  ElevatedButton(onPressed: initialiseUserData, child: Text(l10n.retry))],
        )
            : const CircularProgressIndicator(),
      ),
    );
  }
}