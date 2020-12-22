import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:chores_app/widget/login/inputEmail.dart';
import 'package:chores_app/widget/login/inputUsername.dart';
import 'package:chores_app/widget/login/inputPassword.dart';
import 'package:chores_app/widget/login/textLogin.dart';
import 'package:chores_app/widget/login/verticalText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chores_app/views/home.view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:supercharged/supercharged.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  bool isRegisterMode = false;
  bool termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: ["#628195".toColor(), "#AEC1D0".toColor()]),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    VerticalText(),
                    TextLogin(),
                  ]),
                  if (isRegisterMode)
                    InputUsername(controller: usernameController),
                  InputEmail(controller: emailController),
                  PasswordInput(controller: passwordController),
                  if (isRegisterMode)
                    Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: SwitchListTile(
                            title: const Text('I accept the terms'),
                            activeTrackColor: "#31556D".toColor(),
                            activeColor: "#155E7E".toColor(),
                            value: termsAccepted,
                            onChanged: (bool value) {
                              setState(() {
                                termsAccepted = value;
                              });
                            })),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, right: 50, left: 200),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[350],
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: Offset(
                              2.0,
                              2.0,
                            ),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: isLoading
                          ? Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                  CircularProgressIndicator()
                                ]))
                          : FlatButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    isRegisterMode ? 'Register' : 'Login',
                                    style: TextStyle(
                                      color: "#18718F".toColor(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: "#18718F".toColor(),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  isRegisterMode ? register() : login();
                                }
                              },
                            ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 75),
                      child: Center(
                          child: FlatButton(
                        onPressed: () {
                          setState(() {
                            isRegisterMode = !isRegisterMode;
                          });
                        },
                        child: Text(
                          isRegisterMode ? 'Login' : 'Register',
                        ),
                      ))),
                  if (!isRegisterMode)
                    Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Center(
                            child: FlatButton(
                          onPressed: () {
                            resetPassword();
                          },
                          child: Text(
                            'PAsswort vergessen?',
                          ),
                        )))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      isLoading = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }).catchError((err) {
      FirebaseCrashlytics.instance.recordError(err.message, StackTrace.current);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      isLoading = false;
    });
  }

  void resetPassword() async {
    TextEditingController resetController = TextEditingController();
    RegExp regExp = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
      caseSensitive: false,
      multiLine: false,
    );
    await showDialog<String>(
        context: context,
        child: new AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: TextFormField(
                controller: resetController,
                cursorColor: "#18718F".toColor(),
                style: TextStyle(
                  color: "#31556D".toColor(),
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: "#31556D".toColor()),
                  ),
                  labelText: 'E-Mail Adresse',
                  labelStyle: TextStyle(
                    color: "#31556D".toColor(),
                  ),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Enter Email Address';
                  } else if (!regExp.hasMatch(value)) {
                    return 'Please enter a valid email address!';
                  }
                  return null;
                },
              ))
            ],
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('Abbrechen'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('Zurücksetzen'),
                onPressed: () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: resetController.text)
                      .then((res) {
                    Navigator.pop(context);
                  }).catchError((err) {
                    FirebaseCrashlytics.instance.log(err.message);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text(err.message),
                            actions: [
                              FlatButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  });
                })
          ],
        ));
  }

  void register() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.doc(result.user.uid).set({
        "email": emailController.text,
        "username": usernameController.text
      }).then((res) {
        isLoading = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      });
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      isLoading = false;
    });
  }
}
