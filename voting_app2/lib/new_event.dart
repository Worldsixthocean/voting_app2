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
  List<DateTime> propsedTime = <DateTime>[];

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
              spacing: 8.0, // gap between adjacent chips
              runSpacing: 4.0, // gap between lines
              children: <Widget>[
                for (var i in propsedTime)
                  Chip(
                    backgroundColor: Colors.transparent,
                    avatar: Icon(Icons.date_range),
                    label: Text(
                      "${i.day}/${i.month}/${i.year} ${i.hour.toString().padLeft(2,'0')}:${i.minute.toString().padLeft(2,'0')}"
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
                              DateTime(
                                dt.year,
                                dt.month,
                                dt.day,
                                tod.hour,
                                tod.minute
                              ));
                          });
                        }
                      }
                    },
                  )
              ]
            )

          ]
        ),
      ),
    );
  }
}