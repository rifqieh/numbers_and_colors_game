import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubes_sda/providers/theme-changer.dart';
import 'package:tubes_sda/screens/first4-screen.dart';
import 'second4-screen.dart';
import 'package:tubes_sda/screens/first6-screen.dart';
import 'second6-screen.dart';
import '../block.dart';

class ModeScreen extends StatefulWidget {
  @override
  _ModeScreenState createState() => _ModeScreenState();
}

class _ModeScreenState extends State<ModeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Select Mode'),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (theme.getGameColorId() == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => First4Screen()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Second4Screen()));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent),
                  width: 300,
                  height: 70,
                  child: Center(
                    child: Text(
                      '4 X 4',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  if (theme.getGameColorId() == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => First6Screen()));
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Second6Screen()));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.redAccent),
                  width: 300,
                  height: 70,
                  child: Center(
                    child: Text(
                      '6 X 6',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
