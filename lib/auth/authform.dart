//ignore_for_file: unused_field, sized_box_for_whitespace, prefer_const_constructors, unnecessary_new,avoid_print,avoid_unnecessary_containers
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  bool isLoginPage = false;
  var _username = '';

  //--------------------------------------
  startauthentication() {
    final validity = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (validity) {
      _formkey.currentState!.save();
      submitform(_email, _password, _username);
    }
  }

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    UserCredential authresult;
    try {
      if (isLoginPage) {
        authresult = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authresult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String uid = authresult.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': username,
          'email': email,
        });
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(30),
            height: 200,
            child: Image.asset('assets/todo.png'),
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isLoginPage)
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Incorrect username';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value!;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(8.0),
                            borderSide: new BorderSide()),
                        labelText: "Enter Username",
                        labelStyle: GoogleFonts.roboto(),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Incorrect Email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: new BorderSide()),
                      labelText: "Enter Email",
                      labelStyle: GoogleFonts.roboto(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Incorrect Password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(8.0),
                          borderSide: new BorderSide()),
                      labelText: "Enter Password",
                      labelStyle: GoogleFonts.roboto(),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    height: 70,
                    width: double.infinity,
                    child: ElevatedButton(
                      child: isLoginPage
                          ? Text(
                              'Login',
                              style: GoogleFonts.roboto(fontSize: 16),
                            )
                          : Text(
                              'SignUp',
                              style: GoogleFonts.roboto(fontSize: 16),
                            ),
                      onPressed: (() {
                        startauthentication();
                      }),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).primaryColor)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: TextButton(
                        onPressed: (() {
                          setState(() {
                            isLoginPage = !isLoginPage;
                          });
                        }),
                        child: isLoginPage
                            ? Text(
                                'Not a Member?',
                                style: GoogleFonts.roboto(
                                    fontSize: 16, color: Colors.white),
                              )
                            : Text('Already a Member?',
                                style: GoogleFonts.roboto(
                                    fontSize: 16, color: Colors.white))),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
