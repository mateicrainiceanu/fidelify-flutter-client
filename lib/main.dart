import 'package:fidelify_client/providers/api_service.dart';
import 'package:fidelify_client/providers/auth_user_provider.dart';
import 'package:fidelify_client/screens/dash.dart';
import 'package:fidelify_client/screens/loading_screen.dart';
import 'package:fidelify_client/utils/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        theme: ThemeData(
          primaryColor: const Color(0xFF3B62FF),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B62FF)),
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B62FF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Color(0xFF3B62FF),
              ),
            ),
            labelStyle: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoadingScreen(),
          '/login': (context) => const LoginScreen(),
          '/dash': (context) => Dash(),
        },
      ),
    );
  }
}
