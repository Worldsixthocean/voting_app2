import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

@override
  Widget build(BuildContext context) {

    return Scaffold(body: LoginForm());
    
  }

  }

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children:[

          TextFormField(
            decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your email',
            ),
            controller: usernameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),

          TextFormField(
            decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your password',
            ),
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            }
          ),

          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: usernameController.text,
                    password: passwordController.text
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    print('No user found for that email.');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong password provided for that user.');
                  }
                  final snackBar = SnackBar(
                    content: Text(e.code));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
            }, 
            child: Text('login')),

            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/register');
              },
              child: Text('register screen'))
            
        ]
      ),
    );
  }
}