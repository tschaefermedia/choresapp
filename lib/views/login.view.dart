import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:chores_app/widget/login/inputEmail.dart';
import 'package:chores_app/widget/login/inputPassword.dart';
import 'package:chores_app/widget/login/textLogin.dart';
import 'package:chores_app/widget/login/verticalText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chores_app/views/home.view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
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
              colors: [Colors.cyan[900], Colors.cyan[100]]),
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
                  InputEmail(controller: emailController),
                  PasswordInput(controller: passwordController),
                  if (isRegisterMode)
                    Padding(
                        padding: const EdgeInsets.only(left: 50, right: 50),
                        child: SwitchListTile(
                            title: const Text('I accept the terms'),
                            activeTrackColor: Colors.cyan[600],
                            activeColor: Colors.cyan[50],
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
                                      color: Colors.cyan,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.cyan,
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
        MaterialPageRoute(builder: (context) => Home(uid: result.user.uid)),
      );
    }).catchError((err) {
      print(err.message);
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

  void register() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      users.doc(result.user.uid).set({
        "email": emailController.text,
      }).then((res) {
        isLoading = false;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(uid: result.user.uid)),
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
