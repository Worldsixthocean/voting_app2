import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_app2/app_drawer.dart';
import 'package:voting_app2/auth_state.dart';

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

class Home extends StatelessWidget {
  const Home({
    super.key
  });

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
                ),
                Consumer<AppAuthState>(builder: (context, state, child) => Text(state.getUserID())
                ),
                ElevatedButton(
                  onPressed: () async {
                    print(await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100)));
                    print('hi');
                  }, 
                  child: Text('date')
                ),
              ]
            ),
          ),
        ),
      ],
    );
  }
}
