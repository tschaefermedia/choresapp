import 'package:flutter/material.dart';
import 'package:chores_app/generated/l10n.dart';

class VerticalText extends StatefulWidget {
  @override
  _VerticalTextState createState() => _VerticalTextState();
}

class _VerticalTextState extends State<VerticalText> {
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
                    S.of(context).loginVerticalText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                    ),
                  )))),
    );
  }
}
