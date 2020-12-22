import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;

  PasswordInput({Key key, @required this.controller}) : super(key: key);
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 50, right: 50),
      child: Container(
        height: 75,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: widget.controller,
          cursorColor: "#18718F".toColor(),
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: "#AEC1D0".toColor()),
            ),
            labelText: 'Passwort',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Enter Password';
            } else if (value.length < 8) {
              return 'Password must be atleast 8 characters!';
            }
            return null;
          },
        ),
      ),
    );
  }
}
