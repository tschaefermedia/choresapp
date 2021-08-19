import 'package:flutter/material.dart';

class InputUsername extends StatefulWidget {
  final TextEditingController controller;

  InputUsername({Key? key, required this.controller}) : super(key: key);
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
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: 'Username', 
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter Username';
            }
            return null;
          },
        ),
      ),
    );
  }
}
