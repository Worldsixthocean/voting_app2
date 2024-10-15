import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';  

import 'package:flutter/material.dart';
import 'package:voting_app2/route.dart';
import 'auth_state.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (context) => AppAuthState(),
    builder: ((context, child) => const MyApp()),
  ));


}
