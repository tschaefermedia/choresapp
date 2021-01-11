import 'package:flutter/material.dart';
import 'package:chores_app/widget/home/header.dart';
import 'package:chores_app/widget/home/choresList.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String title = "Die Haushaltsapp";

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(slivers: [
        Header(),
        SliverList(
            delegate: SliverChildListDelegate([
          new ChoresList(),
        ]))
      ]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) {
          // Respond to item press.
          setState(() => _currentIndex = value);
        },
        items: [
          BottomNavigationBarItem(
            label: 'Aufgaben',
            icon: Icon(Icons.cleaning_services),
          ),
          BottomNavigationBarItem(
            label: 'Neu',
            icon: Icon(Icons.add_circle_rounded),
          ),
          BottomNavigationBarItem(
            label: 'Einstellungen',
            icon: Icon(Icons.settings, size: 24),
          ),
        ],
      ),
    );
  }
}
