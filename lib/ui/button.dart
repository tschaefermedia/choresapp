import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final bool isDisabled;
  final String type;
  final String role;

  Button(
      {this.isDisabled = false, this.type = 'elevated', this.role = 'primary'})
      : super();

  @override
  State<StatefulWidget> createState() {
    return ButtonState();
  }
}

class ButtonState extends State<Button> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Widget();
  }
}
