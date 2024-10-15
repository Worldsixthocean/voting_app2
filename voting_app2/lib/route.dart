import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:voting_app2/app_shell.dart';
import 'package:voting_app2/auth_state.dart';
import 'package:voting_app2/event_list.dart';
import 'package:voting_app2/home.dart';
import 'package:voting_app2/login_screen.dart';
import 'package:voting_app2/register.dart';

  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  final _routerLogin = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
          path: '/register',
          builder: (context, state) => RegisterScreen(),
      ),
    ]
  );

  final _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return AppShell(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/home',
            builder: (context, state) => const Home()
          ),
          GoRoute(
            path: '/event',
            builder: (context,state) => EventList()
          )
        ]
      )
    ]
  );

class MyApp extends StatelessWidget{
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return Consumer<AppAuthState>(
      builder: (context, authState, child) {
        return MaterialApp.router(
          routerConfig: authState.loggedIn ? _router : _routerLogin
        );
      }
    );
  }
}
