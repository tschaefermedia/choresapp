import 'package:flutter/material.dart';

class VerticalText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 40, right: 20),
      child: Container(
          height: 200,
          child: Center(
              child: RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                    ),
                  )))),
    );
  }
}
