import 'package:flutter/material.dart';

class HeroHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: true,
      pinned: true,
      snap: false,
      elevation: 10,
      forceElevated: true,
      flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text('Die Haushaltsapp',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 16.0,
              )),
          background: Image.network(
            'https://images.pexels.com/photos/6003/man-hand-car-black.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
            fit: BoxFit.cover,
          )),
    );
  }
}
