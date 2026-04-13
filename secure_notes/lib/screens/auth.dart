import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:securenotes/l10n/app_localizations.dart';
import 'package:securenotes/screens/notes.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final LocalAuthentication _auth = LocalAuthentication();

  String? _message;
  bool _isAuthenticating = false;



@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) => _authenticate());
}


  Future<void> _authenticate() async {
    final l10n = AppLocalizations.of(context)!;

    final bool canCheck = await _auth.canCheckBiometrics;

    if (!canCheck) {
      setState(() {
        _message = l10n.authFailed;
      });
      return;
    }

    try {
      setState(() {
        _isAuthenticating = true;
        _message = l10n.authReason;
      });

      final bool authenticated = await _auth.authenticate(
        localizedReason: l10n.authReason,
        options: const AuthenticationOptions(biometricOnly: true),
      );

      if (!mounted) return;

      if (authenticated) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const NotesScreen()));
      } else {
        setState(() => _message = l10n.authFailed);
      }
    } catch (e) {
      setState(() => _message = 'Error: ${e.toString()}');
    } finally {
      setState(() {
        _isAuthenticating = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
        body : Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 60,
              left: 24,
              right: 24,
              bottom: 24,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF6C63FF),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: const Text(
              'SecureNotes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
    );
  }
}
  