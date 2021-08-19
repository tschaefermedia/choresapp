import 'package:chores_app/pages/settings.dart';
import 'package:chores_app/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:chores_app/pages/chores.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String title = "Die Haushaltsapp";

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  final List<Widget?> _listOfScreens = [
    ChoresPage(),
    null,
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Authentication().setupAuthListener(context);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: _listOfScreens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) {
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
