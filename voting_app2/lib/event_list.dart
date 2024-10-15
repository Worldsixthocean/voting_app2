
import 'package:flutter/material.dart';
import 'package:voting_app2/new_event.dart';


class EventList extends StatefulWidget {
  const EventList({
    super.key
  });

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: []
          ),
          // Align(
          //   alignment: FractionalOffset(0.9, 0.9),
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (context) => const NewEvent()
          //         )
          //       );
          //     },
          //     child: Text('New Event'),
          //   )
          // )
        ]
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NewEvent()
            )
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('New Event'),
      ),
    );
  }
}
