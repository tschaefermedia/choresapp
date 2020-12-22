import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

class InputUsername extends StatefulWidget {
  final TextEditingController controller;

  InputUsername({Key key, @required this.controller}) : super(key: key);
  @override
  _InputUsernameState createState() => _InputUsernameState();
}

class _InputUsernameState extends State<InputUsername> {
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
            labelText: 'Username',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return 'Enter Username';
            }
            return null;
          },
        ),
      ),
    );
  }
}
