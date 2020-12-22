import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

class InputEmail extends StatefulWidget {
  final TextEditingController controller;

  InputEmail({Key key, @required this.controller}) : super(key: key);
  @override
  _InputEmailState createState() => _InputEmailState();
}

class _InputEmailState extends State<InputEmail> {
  RegExp regExp = new RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
    caseSensitive: false,
    multiLine: false,
  );

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
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: "#AEC1D0".toColor()),
            ),
            labelText: 'E-Mail Adresse',
            labelStyle: TextStyle(
              color: Colors.white,
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
        ),
      ),
    );
  }
}
