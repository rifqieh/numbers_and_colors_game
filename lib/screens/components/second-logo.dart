import 'package:flutter/material.dart';

class SecondLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Colors.deepPurple,
              child: Container(
                width: 50,
                height: 50,
              ),
            ),
            Card(
              color: Colors.deepOrange,
              child: Container(
                width: 50,
                height: 50,
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Colors.teal,
              child: Container(
                width: 50,
                height: 50,
              ),
            ),
            Card(
              color: Colors.cyan,
              child: Container(
                width: 50,
                height: 50,
              ),
            )
          ],
        ),
      ],
    );
  }
}
