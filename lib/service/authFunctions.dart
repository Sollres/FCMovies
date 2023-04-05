import 'package:films/service/firebaseFunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthServices {
  static signupUser(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await FirestoreServices.saveUser(name, email, userCredential.user!.uid);

      // Redirect to the Home page after successful sign-in
      Navigator.pushReplacementNamed(context, '/home');

      // Wrap ScaffoldMessenger in a Builder widget
      Builder(builder: (context) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Registration Successful')));
        return SizedBox.shrink();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Builder(builder: (context) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password Provided is too weak')));
          return SizedBox.shrink();
        });
      } else if (e.code == 'email-already-in-use') {
        Builder(builder: (context) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Email Provided already Exists')));
          return SizedBox.shrink();
        });
      }
    } catch (e) {
      Builder(builder: (context) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        return SizedBox.shrink();
      });
    }
  }

  static signinUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Redirect to the Home page after successful sign-in
      Navigator.pushReplacementNamed(context, '/home');

      // Show a success message to the user
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('You are Logged in')));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user Found with this Email')));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Password did not match')));
      }
    }
  }
}
