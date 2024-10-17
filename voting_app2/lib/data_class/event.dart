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

  //unused
  /*
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
  */

  //from firestore single
  factory UserSnippet.fromDyanmic(dynamic d){
    return UserSnippet(
      email: d['email'],
      name: d['name'],
      uidInEvent: d['uidInEvent'],
      uid: d['uid']
    );
  }

  //from firestore list
  static List<UserSnippet> fromDyanmicList(List<dynamic> dList){
    var output = <UserSnippet>[];
    for (var i in dList){
      output.add(UserSnippet.fromDyanmic(i));
    }
    return output;
  }

  //to firestore type single item
  Map<String,dynamic> toMap(){
    return {
      'email': email,
      'name' : name,
      'uidInEvent' : uidInEvent,
      'uid' : uid
    };
  }

  //to firestore type list
  static List<Map<String,dynamic>> toListOfMap(List<UserSnippet> list){
    var output = <Map<String,dynamic>>[];
    for (var i in list){
      output.add(i.toMap());
    }
    return output;
  }

  //util:print class object for debug
  @override
  String toString(){
    return(
'''
  {
    email: $email
    name: $name
    uidInEvent: $uidInEvent
    uid: $uid
  }
'''
    );
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

  //unused
  /*
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
  */

  //from firestore single item
  factory PropsedTime.fromDyanmic(dynamic d){
    return PropsedTime(
      available: 
        d['available'] is Iterable ? List.from(d['available']) : <int>[],
      date: 
        d['date'] is Timestamp ? d['date'].toDate() : throw('${d['available']} is not a timestamp'),
      maybe: 
        d['maybe'] is Iterable ? List.from(d['maybe']) : <int>[]
    );
  }

  //from firestore list
  static List<PropsedTime> fromDyanmicList(List<dynamic> dList){
    var output = <PropsedTime>[];
    for (var i in dList){
      output.add(PropsedTime.fromDyanmic(i));
    }
    return output;
  }

  //to firestore single item
  Map<String,dynamic> toMap(){
    return {
      'available': available,
      'date' : date,
      'maybe' : maybe
    };
  }

  //to firestore list
  static List<Map<String,dynamic>> toListOfMap(List<PropsedTime> list){
    var output = <Map<String,dynamic>>[];
    for (var i in list){
      output.add(i.toMap());
    }
    return output;
  }
  //util:print class object for debug
  @override
  String toString(){
    return(
'''
  {
    available: $available
    date: $date
    maybe: $maybe
  }
'''
    );
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
    final attendees = UserSnippet.fromDyanmicList(data!['attendees']);
    final dates = PropsedTime.fromDyanmicList(data['dates']);
    final organizers = UserSnippet.fromDyanmicList(data['organizers']);
    final pending = UserSnippet.fromDyanmicList(data['pending']);

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
      "organizers": UserSnippet.toListOfMap(organizers), 
      "pending": UserSnippet.toListOfMap(pending), 
      "counter": counter
    };
  }

  //util:print class object for debug
  @override
  String toString(){
    return(
'''{
  eventsName: $eventsName
  description: $description
  organizers: ${organizers.toString()}
  attendees: ${attendees.toString()}
  pending: ${pending.toString()}
  counter: $counter
}'''
    );
  }

}