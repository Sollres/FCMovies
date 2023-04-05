import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class SignOutButton extends StatelessWidget {
  const SignOutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        try {
          await FirebaseAuth.instance.signOut();
          // Navigate to the login page after signing out
          Navigator.pushReplacementNamed(context, '/login');
        } catch (e) {
          print('Error signing out: $e');
        }
      },
      child: Text(AppLocalizations.of(context)!.signout),
    );
  }
}