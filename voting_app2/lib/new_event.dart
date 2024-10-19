import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:voting_app2/data_class/event.dart';

class NewEventWrapper extends StatefulWidget {
  NewEventWrapper({
    super.key,
    required this.uid
  });

  final String uid;

  @override
  _NewEventWrapperState createState() => _NewEventWrapperState();
}

class _NewEventWrapperState extends State<NewEventWrapper> {
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

        if (snapshot.data == null) {
          return const Text("Error: cannot retrive user data");
        }
        return NewEvent(snapshot: snapshot.data!);
      },
    );
  }
}

class NewEvent extends StatefulWidget {
  const NewEvent({
    super.key,
    required this.snapshot
  });

  final DocumentSnapshot snapshot;

  @override
  State<NewEvent> createState() => _NewEvent();
}

class _NewEvent extends State<NewEvent> {

  late final currentUser = UserSnippet(
    email: widget.snapshot['email'], 
    name: widget.snapshot['user'], 
    uidInEvent: 1
  );

  final _formKey = GlobalKey<FormState>();
  final eventNameC = TextEditingController();
  final descriptionC = TextEditingController();
  List<ProposedTime> propsedTime = <ProposedTime>[];
  late List<UserSnippet> organizers = <UserSnippet>[currentUser];
  late List<UserSnippet> attendees = <UserSnippet>[currentUser];
  late List<UserSnippet> pending = <UserSnippet>[];
  int counter = 1;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    eventNameC.dispose();
    descriptionC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
      
            TextFormField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Event Name',
              ),
              controller: eventNameC,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter Event Name';
                }
                return null;
              },
            )
            ,
            TextFormField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Description',
              ),
              controller: descriptionC,
            )
            ,
            Text('Organizers:')
            ,
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: <Widget>[
                for (var i in organizers)
                  Chip(
                    backgroundColor: Colors.transparent,
                    avatar: Icon(Icons.person),
                    label: Text(i.name),
                    // need at least 1 organizer
                    onDeleted: organizers.length > 1 ? () {
                      setState(() {
                        organizers.remove(i);
                      });
                    } : null,
                    deleteIcon: Icon(Icons.close)
                  ),
                  ActionChip(
                    avatar: Icon(Icons.add),
                    label: Text('Invite a new person'),
                    backgroundColor: Colors.transparent,
                    onPressed: () {},
                  )
              ]
            )
            ,
            Text('Attendees:'),
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: <Widget>[
                for (var i in attendees)
                  Chip(
                    backgroundColor: Colors.transparent,
                    avatar: Icon(Icons.person),
                    label: Text(i.name),
                    onDeleted: () {
                      setState(() {
                        attendees.remove(i);
                      });
                    },
                    deleteIcon: Icon(Icons.close)
                  )
                  ,
                for (var i in pending)
                  Chip(
                    backgroundColor: Colors.transparent,
                    avatar: Icon(Icons.person),
                    label: Text("${i.name} (pending)"),
                    onDeleted: () {
                      setState(() {
                        pending.remove(i);
                      });
                    },
                    deleteIcon: Icon(Icons.close)
                    )
                    ,
                  ActionChip(
                    avatar: Icon(Icons.add),
                    label: Text('Invite a new person'),
                    backgroundColor: Colors.transparent,
                    onPressed: () {},
                  )
              ]
            )
            ,
            Text('Proposed time:')
            ,
            Wrap(
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: <Widget>[
                for (var i in propsedTime)
                  Chip(
                    backgroundColor: Colors.transparent,
                    avatar: Icon(Icons.date_range),
                    label: Text(
                      "${i.date.day}/${i.date.month}/${i.date.year} " + 
                      "${i.date.hour.toString().padLeft(2,'0')}:${i.date.minute.toString().padLeft(2,'0')}"
                    ),
                    onDeleted: () {
                      setState(() {
                        propsedTime.remove(i);
                      });
                    },
                    deleteIcon: Icon(Icons.close)
                  ),
                  ActionChip(
                    avatar: Icon(Icons.add),
                    label: Text('Propose a new time'),
                    backgroundColor: Colors.transparent,
                    onPressed: () async{
                      DateTime? dt = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), 
                          firstDate: DateTime(2000), 
                          lastDate: DateTime(2100)
                        );
                      if(dt != null && context.mounted){
                        TimeOfDay? tod = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now()
                        );
                        if(tod!=null){
                          setState(() {
                            propsedTime.add(
                              ProposedTime(
                                available: <int>[], 
                                date: DateTime(
                                  dt.year,
                                  dt.month,
                                  dt.day,
                                  tod.hour,
                                  tod.minute
                                ), 
                                maybe: <int>[])
                            );
                          });
                        }
                      }
                    },
                  )
              ]
            )
            ,

          ]
        ),
      ),
    );
  }
}