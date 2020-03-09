import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tubes_sda/providers/theme-changer.dart';
import 'package:tubes_sda/screens/components/first-logo.dart';
import 'package:tubes_sda/screens/components/second-logo.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var bgColor;
  var text;
  var textColor;
  var borderColor;
  var textSound;
  var soundColor;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    if (theme.getTheme() == ThemeData.dark()) {
      bgColor = Colors.white;
      text = 'LIGHT MODE';
      textColor = Colors.black;
      borderColor = Colors.white;
    } else {
      bgColor = Colors.black;
      text = 'DARK MODE';
      textColor = Colors.white;
      borderColor = Colors.black;
    }
    if (theme.getSoundStatusId() == 0) {
      textSound = 'SOUND OFF';
      soundColor = Colors.redAccent;
    } else {
      textSound = 'SOUND ON';
      soundColor = Colors.blueAccent;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Setting'),
        ),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (theme.getSoundStatusId() == 0) {
                      theme.setSoundStatusId(1);
                    } else {
                      theme.setSoundStatusId(0);
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: soundColor),
                    width: 300,
                    height: 70,
                    child: Center(
                      child: Text(
                        textSound,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    if (theme.getTheme() == ThemeData.dark())
                      theme.setTheme(ThemeData.light());
                    else
                      theme.setTheme(ThemeData.dark());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: bgColor),
                    width: 300,
                    height: 70,
                    child: Center(
                      child: Text(
                        text,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        theme.setGameColorId(1);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 5,
                              color: (theme.getGameColorId() == 1
                                  ? borderColor
                                  : Colors.transparent)),
                        ),
                        child: FirstLogo(),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        theme.setGameColorId(2);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 5,
                              color: (theme.getGameColorId() == 2
                                  ? borderColor
                                  : Colors.transparent)),
                        ),
                        child: SecondLogo(),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
