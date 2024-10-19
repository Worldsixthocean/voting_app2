import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserInformation extends StatefulWidget {
  UserInformation({
    super.key,
    required this.uid
  });

  final String uid;

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  late final Stream<DocumentSnapshot> _usersStream =
      FirebaseFirestore.instance.collection('user').doc(widget.uid).snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return Column(
          children: [
            Text(snapshot.data!['user']),
            Text(snapshot.data!['email']),
            Text(snapshot.data!['uid']),
          ]
        );
      },
    );
  }
}