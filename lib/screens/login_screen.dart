import 'package:chores_app/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:chores_app/widgets/login/inputEmail.dart';
import 'package:chores_app/widgets/login/inputUsername.dart';
import 'package:chores_app/widgets/login/inputPassword.dart';
import 'package:chores_app/widgets/login/textLogin.dart';
import 'package:chores_app/widgets/login/verticalText.dart';
import 'package:chores_app/screens/home_screen.dart';
import 'package:chores_app/providers/email_auth_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      child: isLoading
                          ? Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                  CircularProgressIndicator()
                                ]))
                          : ElevatedButton(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    isRegisterMode ? 'Register' : 'Login',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Palette.dark['green']
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                  ),
                                ],
                              ),
                              /* shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              padding: EdgeInsets.all(10.0),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? Colors.cyan[600]
                                  : Colors.cyan[800], */
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
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
                          child: ElevatedButton(
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
                            child: ElevatedButton(
                          onPressed: () {
                            resetPassword();
                          },
                          child: Text(
                            'Passwort vergessen?',
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

  void login() async {
    bool loginStatus = await EmailAuthProvider().login(
        email: emailController.text,
        password: passwordController.text,
        context: context);
    if (loginStatus) {
      isLoading = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      isLoading = false;
    }
  }

  void resetPassword() async {
    TextEditingController resetController = TextEditingController();
    RegExp regExp = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
      caseSensitive: false,
      multiLine: false,
    );
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) => new AlertDialog(
              insetPadding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 250.0),
              title:
                  new Text("Zum Passwort zurücksetzen, bitte E-Mail angeben!"),
              content: new Row(
                children: <Widget>[
                  new Expanded(
                      child: TextFormField(
                    controller: resetController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'E-Mail Adresse',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
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
                new ElevatedButton(
                    child: const Text('Abbrechen'),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                new ElevatedButton(
                    child: const Text('Zurücksetzen'),
                    onPressed: () async {
                      await EmailAuthProvider()
                          .resetPassword(email: resetController.text);
                      Navigator.pop(context);
                    })
              ],
            ));
  }

  void register() async {
    bool registerStatus = await EmailAuthProvider().register(
        email: emailController.text,
        password: passwordController.text,
        username: usernameController.text,
        context: context);
    if (registerStatus) {
      isLoading = false;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      isLoading = false;
    }
  }
}
