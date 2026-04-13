import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:secure_notes/l10n/app_localizations.dart';
import 'package:secure_notes/src/AuthScreen.dart';
import 'package:secure_notes/model/Database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 👈 required for DB init
  await DatabaseHelper.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const AuthScreen(),
    );
  }
}
