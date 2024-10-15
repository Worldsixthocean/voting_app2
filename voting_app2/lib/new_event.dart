import 'package:flutter/material.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({
    super.key,
  });

  @override
  State<NewEvent> createState() => _NewEvent();
}

class _NewEvent extends State<NewEvent> {

  final _formKey = GlobalKey<FormState>();
  final eventNameC = TextEditingController();
  final descriptionC = TextEditingController();

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
            ),
      
            TextFormField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Description',
              ),
              controller: descriptionC,
            ),

            Wrap(
              children: [
                
              ],
            )
          ]
        ),
      ),
    );
  }
}