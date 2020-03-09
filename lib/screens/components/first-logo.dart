import 'package:flutter/material.dart';

class FirstLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Colors.redAccent,
              child: Container(
                width: 50,
                height: 50,
              ),
            ),
            Card(
              color: Colors.amberAccent,
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
              color: Colors.greenAccent,
              child: Container(
                width: 50,
                height: 50,
              ),
            ),
            Card(
              color: Colors.blueAccent,
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
