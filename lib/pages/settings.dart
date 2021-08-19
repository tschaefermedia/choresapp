import 'package:chores_app/providers/authentication_provider.dart';
import 'package:chores_app/widgets/layout/app_bar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(appBar: CustomAppBar(pageName: "Settings"), body: new SafeArea(child: new Column(children: [
      new OutlinedButton(onPressed: () => Authentication().logout(), child: new Text("Logout"))
    ],)),);
  }
}
