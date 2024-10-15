import 'package:flutter/material.dart';
import 'package:voting_app2/app_drawer.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
