import 'package:flutter/material.dart';

class TextLogin extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 0, right: 0),
        child: Container(
          height: 200,
          width: 200,
          child: Center(
            child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ));
  }
}
