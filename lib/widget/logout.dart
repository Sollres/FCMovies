import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



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
      child: const Text('Sign out'),
    );
  }
}