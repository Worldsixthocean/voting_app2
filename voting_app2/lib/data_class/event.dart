import 'package:cloud_firestore/cloud_firestore.dart';

class UserSnippet {
  String email;
  String name;
  int uidInEvent; 
  String? uid;

  UserSnippet({
    required this.email,
    required this.name,
    required this.uidInEvent,
    this.uid
  });

  // String get getEmail => email;
  // String get getName => name;
  // int get getUidInEvent => uidInEvent;
  // String? get getUid => uid;

  // set setEmail(String input) => email = input;
  // set setName(String input) => name = input;
  // set setUidInEvent(int input) => uidInEvent = input;
  // set setUid(String input) => uid = input;

  factory UserSnippet.fromMap(Map<String, dynamic> map){
    return UserSnippet(
      email: map['email'],
      name: map['name'],
      uidInEvent: map['uidInEvent'],
      uid: map['uid']
    );
  }

  static List<UserSnippet> generateListOfUserSnippets(List<Map<String,dynamic>> list){
    var output = <UserSnippet>[];
    for (var i in list){
      output.add(UserSnippet.fromMap(i));
    }
    return output;
  }

  Map<String,dynamic> toMap(){
    return {
      'email': email,
      'name' : name,
      'uidInEvent' : uidInEvent,
      'uid' : uid
    };
  }

  static List<Map<String,dynamic>> toListOfMap(List<UserSnippet> list){
    var output = <Map<String,dynamic>>[];
    for (var i in list){
      output.add(i.toMap());
    }
    return output;
  }
}

class PropsedTime {
  List<int> available;
  DateTime date;
  List<int> maybe;

  PropsedTime({
    required this.available,
    required this.date,
    required this.maybe
  });

  // List<int> get getAvailable => available;
  // DateTime get getDate => date;
  // List<int> get getMaybe => maybe;

  // set setAvailable(List<int> input) => available = input;
  // set setDate(DateTime input) => date = input;
  // set setMaybe(List<int> input) => maybe = input;

  factory PropsedTime.fromMap(Map<String, dynamic> map){
    return PropsedTime(
      available: 
        map['available'] is Iterable ? List.from(map['available']) : <int>[],
      date: 
        map['date'] is Timestamp ? map['date'].toDate() : throw('${map['available']} is not a timestamp'),
      maybe: 
        map['maybe'] is Iterable ? List.from(map['maybe']) : <int>[]
    );
  }

  static List<PropsedTime> generateListOfPropsedTime(List<Map<String,dynamic>> list){
    var output = <PropsedTime>[];
    for (var i in list){
      output.add(PropsedTime.fromMap(i));
    }
    return output;
  }

  Map<String,dynamic> toMap(){
    return {
      'available': available,
      'date' : date,
      'maybe' : maybe
    };
  }

  static List<Map<String,dynamic>> toListOfMap(List<PropsedTime> list){
    var output = <Map<String,dynamic>>[];
    for (var i in list){
      output.add(i.toMap());
    }
    return output;
  }

}

class Event {
  List<UserSnippet> attendees;
  List<PropsedTime> dates;
  String description;
  String eventsName;
  List<UserSnippet> organizers;
  List<UserSnippet> pending;
  int counter;

  Event({
    required this.attendees,
    required this.dates,
    required this.description,
    required this.eventsName,
    required this.organizers,
    required this.pending,
    required this.counter
  });

  factory Event.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final attendees = UserSnippet.generateListOfUserSnippets(data!['attendees']);
    final dates = PropsedTime.generateListOfPropsedTime(data['dates']);
    final organizers = UserSnippet.generateListOfUserSnippets(data['organizers']);
    final pending = UserSnippet.generateListOfUserSnippets(data['pending']);

    return Event(
      attendees: attendees, 
      dates: dates, 
      description: data['description'], 
      eventsName: data['eventsName'], 
      organizers: organizers, 
      pending: pending, 
      counter: data['counter']
    );
  }
  
  Map<String, dynamic> toFirestore() {
    return{
      "attendees": UserSnippet.toListOfMap(attendees),
      "dates": PropsedTime.toListOfMap(dates), 
      "description": description, 
      "eventsName": eventsName, 
      "organizers": UserSnippet.toListOfMap(attendees), 
      "pending": UserSnippet.toListOfMap(pending), 
      "counter": counter
    };
  }

}