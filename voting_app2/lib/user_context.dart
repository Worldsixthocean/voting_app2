import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:voting_app2/data_class/user.dart' as user_class;
import 'package:flutter/material.dart';

class UserContext extends ChangeNotifier {
  UserContext(this.userDoc) {
    init();
  }

  DocumentReference? userDoc;
  DocumentSnapshot? userDocSnap;

  Future<void> init() async {
  if (userDoc != null)
    {
      userDoc!.snapshots().listen((user) {
        userDoc?.get().then((DocumentSnapshot<Object?> doc) {
          userDocSnap = doc;
        });
        notifyListeners();
      });
    }
  }
}
