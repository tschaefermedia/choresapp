import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String pageName;

  CustomAppBar({required this.pageName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 350,
        elevation: 1,
        backgroundColor: Colors.cyan,
        leading: Navigator.canPop(context)
            ? Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    tooltip:
                        MaterialLocalizations.of(context).backButtonTooltip,
                  );
                },
              )
            : null,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset(
              'assets/logo_transparent_small.png',
              height: 50,
            ),
            SizedBox(width: 10),
            Text(
              '$pageName',
              style: TextStyle(
                color: Colors.cyan[900],
                fontSize: 18,
              ),
            ),
          ],
        ));
  }

  @override
  Size get preferredSize => Size.fromHeight(
    100.00 );
}
