import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formkey = GlobalKey<FormState>();
  var _isLogin = true;
  var _Email = '';
  var _userName = '';
  var _Password = '';

  startauthentication() {
    // print('Email: $_Email');
    // print('Username: $_userName');
    // print('Password: $_Password');
    final isValid = formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      formkey.currentState!.save();
      submitform(_Email, _userName, _Password);
    }
  }

  submitform(String email, String username, String password) async {
    final auth = FirebaseAuth.instance;
    UserCredential userCredential;
    try {
      if (_isLogin) {
        userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCredential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String uid = auth.currentUser!.uid;

        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': username,
          'email': email,
        });
      }
    } on FirebaseAuthException catch (e) {
      String message = 'An error occurred, please check your credentials!';
      if (e.message != null) {
        message = e.message!;
        // }
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(message),
        //     backgroundColor: Theme.of(context).errorColor,
        //   ),
        // );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter username' : null,
                    onSaved: (value) {
                      _userName = value!;
                    },
                    key: ValueKey('username'),
                    decoration: InputDecoration(
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    validator: (value) => value!.isEmpty || !value.contains('@')
                        ? 'Please enter a valid email address'
                        : null,
                    onSaved: (value) {
                      _Email = value!;
                    },
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    validator: (value) => value!.isEmpty || value.length < 6
                        ? 'Password must be at least 6 characters long'
                        : null,
                    onSaved: (value) {
                      _Password = value!;
                    },
                    key: ValueKey('password'),
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
