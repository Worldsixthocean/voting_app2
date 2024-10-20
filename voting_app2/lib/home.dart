import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_app2/auth_state.dart';
import 'package:voting_app2/data_class/event.dart';
import 'package:voting_app2/user_context.dart';
import 'package:voting_app2/widget/doc_subscibe.dart';

class TopArea extends StatelessWidget {
  const TopArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Placeholder()
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TopArea(),
        Expanded(
          flex: 7,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.white,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  }, 
                  child: Text('logout')
                )
                ,
                ElevatedButton(
                  onPressed: () async {
                    FirebaseFirestore db = FirebaseFirestore.instance;
                    Event e = Event(
                      attendees: [UserSnippet(email: 'email', name: 'name', uidInEvent: 1)], 
                      dates: [ProposedTime(available: [1], date: DateTime.now(), maybe: [1])], 
                      description: 'description', 
                      eventsName: 'eventsName', 
                      organizers: [UserSnippet(email: 'email', name: 'name', uidInEvent: 1)], 
                      pending: [UserSnippet(email: 'email', name: 'name', uidInEvent: 1)], 
                      counter: 0
                    );

                    db.collection("event").add(e.toFirestore())
                    .then((documentSnapshot) =>
                      print("Added Data with ID: ${documentSnapshot.id}"));
                  }, 
                  child: Text('test')
                )
                ,
                ElevatedButton(
                  onPressed: (){
                    FirebaseFirestore db = FirebaseFirestore.instance;
                    final docRef = db.collection("event").doc("9oUCmtKzbtCvSWwqsssE");
                      docRef.get().then(
                        (DocumentSnapshot<Map<String, dynamic>> doc) {
                          Event e = Event.fromFirestore(doc, null);
                          print(e.toString());
                        },
                        onError: (e) => print("Error getting document: $e"),
                      );
                  },
                  child: Text('retrive'),
                )
                ,
                Consumer<AppAuthState>(
                  builder: (context, authState, child) {
                    return UserInformation(uid: authState.getUserID());
                  })
              ]
            ),
          ),
        ),
      ],
    );
  }
}
