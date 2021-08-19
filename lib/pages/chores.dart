import 'package:flutter/material.dart';
import 'package:chores_app/widgets/layout/hero.dart';
import 'package:chores_app/widgets/chores/choresList.dart';

class ChoresPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      new HeroHeader(),
      SliverList(
          delegate: SliverChildListDelegate([
        new ChoresList(),
      ]))
    ]);
  }
}
