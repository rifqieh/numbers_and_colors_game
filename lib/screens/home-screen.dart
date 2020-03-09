import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubes_sda/providers/theme-changer.dart';
import 'package:tubes_sda/screens/components/first-logo.dart';
import 'package:tubes_sda/screens/components/second-logo.dart';
import 'package:tubes_sda/screens/mode-screen.dart';
import 'package:tubes_sda/screens/setting-screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'NUMBERS',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
              ),
              (theme.getGameColorId() == 1 ? FirstLogo() : SecondLogo()),
              Text(
                'COLORS',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ModeScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent),
                  width: 300,
                  height: 70,
                  child: Center(
                    child: Text(
                      'PLAY',
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingScreen()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.redAccent),
                  width: 300,
                  height: 70,
                  child: Center(
                    child: Text(
                      'SETTING',
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
