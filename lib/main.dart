import 'package:flutter/material.dart';
import 'package:tubes_sda/providers/theme-changer.dart';
import 'package:tubes_sda/screens/game-over-screen.dart';
import 'package:tubes_sda/screens/home-screen.dart';
import 'package:tubes_sda/screens/mode-screen.dart';
import 'package:provider/provider.dart';
import 'providers/game-model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(ThemeData.dark(), 1, 0),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      home: HomeScreen(),
      theme: theme.getTheme(),
    );
  }
}
