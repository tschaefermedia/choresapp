import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chores_app/views/login.view.dart';
import 'package:supercharged/supercharged.dart';
import 'package:chores_app/widget/home/choreCard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>  {
  final String title = "Die Haushaltsapp";

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: IconButton(
                  icon: Icon(Icons.add_circle_outline,
                      size: 40, color: "#AEC1D0".toColor()),
                  onPressed: () {
                    // Do something
                  }))
        ],
        expandedHeight: 150.0,
        floating: true,
        pinned: true,
        snap: true,
        elevation: 50,
        backgroundColor: "#6E8D9F".toColor(),
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text('Die Haushaltsapp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                )),
            background: Image.network(
              'https://images.pexels.com/photos/6003/man-hand-car-black.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
              fit: BoxFit.cover,
            )),
      ),
      new SliverList(delegate: new SliverChildListDelegate(_buildList(50))),
    ]),
    
    bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        backgroundColor: "#6E8D9F".toColor(),
        selectedItemColor: "#0F3C51".toColor(),
        unselectedItemColor: "#AEC1D0".toColor(),
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

  List _buildList(int count) {
    List<Widget> listItems = List();

    for (int i = 0; i < count; i++) {
      listItems.add(new ChoreCard('sdfjksdhjk'));
    }

    return listItems;
  }
}
