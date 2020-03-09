import 'package:flutter/material.dart';
import 'package:tubes_sda/screens/first4-screen.dart';
import 'package:tubes_sda/screens/first6-screen.dart';
import 'second4-screen.dart';
import 'second6-screen.dart';
import 'package:tubes_sda/screens/home-screen.dart';
import 'package:provider/provider.dart';
import '../providers/theme-changer.dart';

class GameOverScreen extends StatelessWidget {
  var mode;
  var time;
  var bestTime;

  GameOverScreen({this.mode, this.time, this.bestTime});

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    var textColor;
    if (theme.getTheme() == ThemeData.dark())
      textColor = Colors.white;
    else
      textColor = Colors.black;

    var blockList4;
    var blockList6;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Time: ',
                style: TextStyle(
                    fontSize: 40,
                    color: textColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '$time s',
                style: TextStyle(
                    fontSize: 40,
                    color: textColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Best Time: ',
                style: TextStyle(
                    fontSize: 40,
                    color: textColor,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '$bestTime s',
                style: TextStyle(
                    fontSize: 40,
                    color: textColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  if (mode == '4x4') {
                    if (theme.getGameColorId() == 1) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => First4Screen()));
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Second4Screen()));
                    }
                  } else {
                    if (theme.getGameColorId() == 1) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => First6Screen()));
                    } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Second6Screen()));
                    }
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
                      'TRY AGAIN',
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.redAccent),
                  width: 300,
                  height: 70,
                  child: Center(
                    child: Text(
                      'BACK TO MENU',
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
