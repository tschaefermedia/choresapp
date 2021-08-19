import 'dart:async';

import 'package:chores_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chores_app/models/local_user.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class Authentication {

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  setupAuthListener(context) {
     FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  Future<bool> isLoggedIn() async {
    LocalUser? u = await getUser();
    return u != null;
  }

  Future<LocalUser?> getUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      return null;
    }

    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser.uid)
        .get();

    if (!userDoc.exists) {
      return null;
    }

    dynamic user = userDoc.data();

    LocalUser localUser = new LocalUser(
        uid: currentUser.uid,
        name: currentUser.displayName ?? "",
        emailVerified: currentUser.emailVerified,
        username: user["username"],
        email: currentUser.email ?? user!['email']);

    return localUser;
  }

  SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  Future<bool> setUser(
      {required uid, required email, required username}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      users.doc(uid).set({"email": email, "username": username});
      return true;
    } on FirebaseException catch (e, stack) {
      await FirebaseCrashlytics.instance
          .recordError(e.message, stack, reason: e.code, fatal: true);
      return false;
    }
  }

  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }
}
