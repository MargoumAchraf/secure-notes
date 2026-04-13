import 'package:flutter/material.dart';

import 'package:securenotes/l10n/app_localizations.dart';
import 'package:securenotes/screens/auth.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     localizationsDelegates: const [
        AppLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        
      ],
      home: const AuthScreen(),
    );
  }
}
