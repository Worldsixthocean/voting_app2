import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voting_app2/data_class/event.dart';
import 'package:voting_app2/data_class/user.dart' as user_class;
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
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
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
                labelText: 'Name',
            ),
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter username';
              }
              return null;
            },
          ),

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
                //todo:add loading (disable button)
                try {
                  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: usernameController.text,
                    password: passwordController.text
                  );
                  FirebaseFirestore.instance.collection('user').doc(credential.user!.uid).set(
                    user_class.User(
                      email: usernameController.text, 
                      events: <String>[], 
                      organize: <String>[], 
                      pending: <String>[], 
                      uid: credential.user!.uid, 
                      user: nameController.text
                    ).toFirestore()
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