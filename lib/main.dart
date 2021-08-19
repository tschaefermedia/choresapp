import 'package:flutter/material.dart';
import 'dart:async';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'package:chores_app/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:chores_app/providers/authentication_provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final AdaptiveThemeMode? savedThemeMode = null;
    await Authentication().initializeFirebase();
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    runApp(ChoresApp(
        savedThemeMode:
            savedThemeMode != null ? savedThemeMode : AdaptiveThemeMode.dark));
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

class ChoresApp extends StatelessWidget {
  final AdaptiveThemeMode savedThemeMode;
  ChoresApp({Key? key, required this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.cyan,
        accentColor: Colors.amber,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        accentColor: Colors.amber[700],
      ),
      initial: savedThemeMode,
      builder: (theme, darkTheme) => MaterialApp(
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: 'Chores App',
        theme: theme,
        darkTheme: darkTheme,
        home: SplashScreen(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initScreen(context),
    );
  }

  getLoginStatus() async {
    bool status = await Authentication().isLoggedIn();
    route(status);
  }

  route(bool loginStatus) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => loginStatus ? HomeScreen() : LoginScreen()));
  }

  initScreen(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset("assets/logo_transparent.png"),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Text(
              "Splash Screen",
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}
