import 'package:chores_app/widget/home/choreCard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChoresList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference choresRef =
        FirebaseFirestore.instance.collection('chores');

    User currentUser = FirebaseAuth.instance.currentUser;
    return StreamBuilder<QuerySnapshot>(
      stream: choresRef.orderBy('nextDueDate', descending: false).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Padding(
              padding: EdgeInsets.all(10),
              child: Text("Something went wrong!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                  )));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
              padding: EdgeInsets.all(10),
              child: Text("Loading",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                  )));
        }

        return Column(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
          return new ChoreCard(document.data());
        }).toList());
      },
    );
  }
}
