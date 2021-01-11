import 'package:flutter/material.dart';
import 'package:chores_app/generated/l10n.dart';

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
                    S.of(context).loginVerticalText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                    ),
                  )))),
    );
  }
}
