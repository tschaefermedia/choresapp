import 'package:chores_app/providers/authentication_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

class EmailAuthProvider extends Authentication {
  Future<bool> login(
      {required email,
      required password,
      required BuildContext context}) async {
    try {
      UserCredential creds = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return creds.user != null;
    } on FirebaseAuthException catch (e, stack) {
      ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(content: e.message ?? "An error occured"));
      await FirebaseCrashlytics.instance
          .recordError(e.message, stack, reason: e.code, fatal: true);
      return false;
    }
  }

  Future<bool> register(
      {required email,
      required password,
      required username,
      required BuildContext context}) async {
    try {
      UserCredential creds = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      bool setupUser =
          await setUser(uid: creds.user!.uid, email: email, username: username);
      return creds.user != null && setupUser;
    } on FirebaseAuthException catch (e, stack) {
      ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(content: e.message ?? "An error occured"));
      await FirebaseCrashlytics.instance
          .recordError(e.message, stack, reason: e.code, fatal: true);
      return false;
    }
  }

  Future<void> resetPassword({required email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
