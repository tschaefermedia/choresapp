import 'package:flutter/material.dart';

class ChoreCard extends StatelessWidget {

  ChoreCard(this.cardData);

  final dynamic cardData;

  @override
  Widget build(BuildContext context) {
      return Card(
     elevation: 5,
     child: Padding(
       padding: EdgeInsets.all(7),
       child: Column(
         children: <Widget>[
           Row(children: [Text("dfjkhdsjk") ],)
         ]
       )
     ),
   );
  }


}