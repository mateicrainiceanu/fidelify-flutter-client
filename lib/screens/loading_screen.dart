import 'package:fidelify_client/providers/auth_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    initialiseUserData();
  }

  Future<void> initialiseUserData() async {
    final auth = Provider.of<AuthUserProvider>(context, listen: false);

    // Initialize user data
    await auth.init();

    if (!mounted) { return; }
    // Navigate to appropriate screen
    if (auth.isLoggedIn == true) {
      Navigator.of(context).pushNamed("/dash");
    } else if (auth.isLoggedIn == false) {
      Navigator.of(context).pushNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}