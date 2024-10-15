import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(child: 
      ListView(
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () {
                GoRouter.of(context).go('/home');
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Event'),
              onTap: () {
                GoRouter.of(context).go('/event');
                Navigator.pop(context);
              },
            ),
          ],
      )
    ));
  }
}
