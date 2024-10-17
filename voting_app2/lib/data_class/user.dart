import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final List<String> events;
  final List<String> organize;
  final List<String> pending;
  final String uid;
  final String user;

  User({
    required this.email,
    required this.events,
    required this.organize,
    required this.pending,
    required this.uid,
    required this.user
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return User(
      email: data!['email'],
      events: 
        data['events'] is Iterable ? List.from(data['events']) : <String>[],
      organize: 
        data['organize'] is Iterable ? List.from(data['organize']) : <String>[],
      pending: 
        data['pending'] is Iterable ? List.from(data['pending']) : <String>[],
      uid: data['uid'],
      user: data['user']
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "email": email,
      "events": events,
      "organize": organize,
      "pending": pending,
      "uid": uid,
      "user": user,
    };
  }

  @override
  String toString(){
    return(
'''{
  email: $email
  state: $events
  organizers: ${organize.toString()}
  attendees: ${pending.toString()}
  uid: $uid
  name: $user
}'''
    );
  }
}
