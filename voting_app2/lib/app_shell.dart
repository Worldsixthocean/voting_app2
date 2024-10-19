import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:voting_app2/app_drawer.dart';
import 'package:voting_app2/auth_state.dart';
import 'package:voting_app2/user_context.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor:  Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Home')
        ),
        drawer: AppDrawer(),
        body: child,
      );
  }
}
