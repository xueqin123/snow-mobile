import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snowclient/pages/splash/splash_page.dart';
import 'generated/l10n.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(SnowApp());
}

class SnowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [S.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
        accentColor: Colors.yellow,
      ),
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}


