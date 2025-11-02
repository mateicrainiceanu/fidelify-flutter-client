import 'package:fidelify_client/providers/api_service.dart';
import 'package:fidelify_client/providers/auth_user_provider.dart';
import 'package:fidelify_client/screens/dash.dart';
import 'package:fidelify_client/screens/loading_screen.dart';
import 'package:fidelify_client/utils/logger.dart';
import 'package:fidelify_client/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:fidelify_client/screens/login_screen.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthUserProvider(),
          ),
          ProxyProvider<AuthUserProvider, ApiService>(
              update: (context, authUserProvider, apiService) {
                Log.trace("updating authUserProvider tk: ${authUserProvider.token}");
                ApiService.instance.attachAuthProvider(authUserProvider);
                return ApiService.instance;
              }),
        ],
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      config: const ToastificationConfig(
        alignment: Alignment.bottomCenter,
        itemWidth: double.infinity,
        animationDuration: Duration(milliseconds: 200),
        blockBackgroundInteraction: false,
      ),
      child: MaterialApp(
        title: "Fidelify",
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ro')
        ],
        theme: getThemeData(context),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoadingScreen(),
          '/login': (context) => const LoginScreen(),
          '/dash': (context) => const Dash(),
        },
      ),
    );
  }
}
