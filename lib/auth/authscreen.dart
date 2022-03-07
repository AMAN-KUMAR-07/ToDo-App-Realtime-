//ignore_for_file: unused_field, sized_box_for_whitespace, prefer_const_constructors, unnecessary_new
import 'package:flutter/material.dart';
import 'package:todo_app/auth/authform.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Authentication"),
      ),
      body: AuthForm(),
    );
  }
}
