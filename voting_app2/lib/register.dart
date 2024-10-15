import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatelessWidget {
  const  RegisterScreen({
    super.key,
  });

@override
  Widget build(BuildContext context) {

    return Scaffold(body:  RegisterForm());
    
  }

  }

class  RegisterForm extends StatefulWidget {
  const  RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

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
                labelText: 'Email',
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
                labelText: 'Password',
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
                  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: usernameController.text,
                    password: passwordController.text
                  );
                } on FirebaseAuthException catch (e) {
                  final snackBar = SnackBar(
                    content: Text(e.code));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }
            }, 
            child: Text('register')),

            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).go('/login');
              },
              child: Text('login screen'))
            
        ]
      ),
    );
  }
}