import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  int _gameColorId = 0;

  int _soundStatusId = 0;

  ThemeChanger(this._themeData, this._gameColorId, this._soundStatusId);

  getTheme() => _themeData;

  getGameColorId() => _gameColorId;

  getSoundStatusId() => _soundStatusId;

  setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  setGameColorId(int id) {
    _gameColorId = id;
    notifyListeners();
  }

  setSoundStatusId(int id) {
    _soundStatusId = id;
    notifyListeners();
  }
}
