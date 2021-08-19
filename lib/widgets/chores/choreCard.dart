import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ChoreCard extends StatelessWidget {
  ChoreCard(this.cardData);

  final dynamic cardData;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            cardData['name'],
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _getNextDateString(cardData['nextDueDate']),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: _getTimeToDueDate(cardData['nextDueDate']) > 0 ? FontWeight.w500 : FontWeight.w600,
                              color: _getTimeToDueDate(cardData['nextDueDate']) > 0 ? Colors.black : Colors.redAccent

                            ),
                          )
                        ])
                  ])),
              RatingBarIndicator(
                  rating: cardData['difficulty'].toDouble(),
                  itemCount: 3,
                  itemSize: 25.0,
                  itemBuilder: (context, _) => Icon(
                        Icons.cleaning_services,
                        color: Theme.of(context).accentColor
                      )),
              TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.chevron_right, color: Colors.amber, size: 25),
                  ],
                ),
                onPressed: () {
                  print("pressed");
                },
              )
            ],
          ),
        ));
  }

  String _getNextDateString(date) {
    int difference = _getTimeToDueDate(date);
    if (difference > 0) {
      return 'Fällig in $difference Tagen!';
    } else if (difference == 0) {
      return "Heute fällig";
    } else {
      difference = difference * -1;
      return 'Fällig vor $difference Tagen!';
    }
  }

  int _getTimeToDueDate(date) {
    final dueDate = date.toDate();
    final now = DateTime.now();
    return dueDate.difference(now).inDays;
  }
}
