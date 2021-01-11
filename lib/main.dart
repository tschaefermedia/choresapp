import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:chores_app/views/login.view.dart';
import 'package:chores_app/generated/l10n.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:chores_app/views/home.view.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:google_fonts/google_fonts.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supercharged/supercharged.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(Foundation.kDebugMode);
  FirebaseFirestore.instance.settings = Settings(persistenceEnabled: true);
  FirebaseFirestore.instance.settings =
      Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  FlutterError.onError = (details) {
    FirebaseCrashlytics.instance.recordFlutterError(details);
  };
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(ChoresApp(savedThemeMode: savedThemeMode));
}

class ChoresApp extends StatelessWidget {
  final AdaptiveThemeMode savedThemeMode;
  const ChoresApp({Key key, this.savedThemeMode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context)
            .textTheme
            .copyWith(
                headline1: TextStyle(color: "#121212".toColor()),
                headline2: TextStyle(color: "#121212".toColor()),
                headline3: TextStyle(color: "#121212".toColor()),
                headline4: TextStyle(color: "#121212".toColor()),
                headline5: TextStyle(color: "#121212".toColor()),
                headline6: TextStyle(color: "#121212".toColor()),
                subtitle1: TextStyle(color: "#121212".toColor()),
                subtitle2: TextStyle(color: "#121212".toColor()),
                bodyText1: TextStyle(color: "#121212".toColor()),
                bodyText2: TextStyle(color: "#121212".toColor()),
                caption: TextStyle(color: "#121212".toColor()),
                button: TextStyle(color: "#121212".toColor()),
                overline: TextStyle(color: "#121212".toColor()))),
        primarySwatch: Colors.cyan,
        accentColor: Colors.amber,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: "#6E8D9F".toColor(),
          selectedItemColor: "#0F3C51".toColor(),
          unselectedItemColor: "#AEC1D0".toColor(),
        ),
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.nunitoSansTextTheme(Theme.of(context)
            .textTheme
            .copyWith(
                headline1: TextStyle(color: "#eeeeee".toColor()),
                headline2: TextStyle(color: "#eeeeee".toColor()),
                headline3: TextStyle(color: "#eeeeee".toColor()),
                headline4: TextStyle(color: "#eeeeee".toColor()),
                headline5: TextStyle(color: "#eeeeee".toColor()),
                headline6: TextStyle(color: "#eeeeee".toColor()),
                subtitle1: TextStyle(color: "#eeeeee".toColor()),
                subtitle2: TextStyle(color: "#eeeeee".toColor()),
                bodyText1: TextStyle(color: "#eeeeee".toColor()),
                bodyText2: TextStyle(color: "#eeeeee".toColor()),
                caption: TextStyle(color: "#eeeeee".toColor()),
                button: TextStyle(color: "#eeeeee".toColor()),
                overline: TextStyle(color: "#eeeeee".toColor()))),
        primarySwatch: Colors.cyan,
        accentColor: Colors.amber[700],
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: "#354650".toColor(),
          selectedItemColor: "#071d28".toColor(),
          unselectedItemColor: "#AEC1D0".toColor(),
        ),
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
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
        home: IntroScreen(),
      ),
    );
  }
}

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User result = FirebaseAuth.instance.currentUser;
    //setTheme(context);
    return AnimatedTheme(
        duration: Duration(milliseconds: 300),
        data: Theme.of(context),
        child: new SplashScreen(
            navigateAfterSeconds: result != null ? Home() : LoginView(),
            seconds: 3,
            title: new Text(
              'Welcome to the Chores App!',
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            image: Image.asset('assets/images/dart.png'),
            backgroundColor: Theme.of(context).backgroundColor,
            photoSize: 100.0,
            loaderColor: Colors.cyan));
  }
}
