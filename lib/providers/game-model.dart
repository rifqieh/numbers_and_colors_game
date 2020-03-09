import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';

class GameModel extends ChangeNotifier {
  int _timer = 10;

  var _n = 36;

  var themeIndex = 0;

  var _blockList = [
    {"color": Colors.redAccent, "value": 1},
    {"color": Colors.redAccent, "value": 2},
    {"color": Colors.redAccent, "value": 3},
    {"color": Colors.redAccent, "value": 4},
    {"color": Colors.redAccent, "value": 5},
    {"color": Colors.redAccent, "value": 6},
    {"color": Colors.redAccent, "value": 7},
    {"color": Colors.redAccent, "value": 8},
    {"color": Colors.redAccent, "value": 9},
    {"color": Colors.amberAccent, "value": 1},
    {"color": Colors.amberAccent, "value": 2},
    {"color": Colors.amberAccent, "value": 3},
    {"color": Colors.amberAccent, "value": 4},
    {"color": Colors.amberAccent, "value": 5},
    {"color": Colors.amberAccent, "value": 6},
    {"color": Colors.amberAccent, "value": 7},
    {"color": Colors.amberAccent, "value": 8},
    {"color": Colors.amberAccent, "value": 9},
    {"color": Colors.greenAccent, "value": 1},
    {"color": Colors.greenAccent, "value": 2},
    {"color": Colors.greenAccent, "value": 3},
    {"color": Colors.greenAccent, "value": 4},
    {"color": Colors.greenAccent, "value": 5},
    {"color": Colors.greenAccent, "value": 6},
    {"color": Colors.greenAccent, "value": 7},
    {"color": Colors.greenAccent, "value": 8},
    {"color": Colors.greenAccent, "value": 9},
    {"color": Colors.blueAccent, "value": 1},
    {"color": Colors.blueAccent, "value": 2},
    {"color": Colors.blueAccent, "value": 3},
    {"color": Colors.blueAccent, "value": 4},
    {"color": Colors.blueAccent, "value": 5},
    {"color": Colors.blueAccent, "value": 6},
    {"color": Colors.blueAccent, "value": 7},
    {"color": Colors.blueAccent, "value": 8},
    {"color": Colors.blueAccent, "value": 9},
  ];

  var _blockRule = [
    Colors.redAccent,
    Colors.amberAccent,
    Colors.greenAccent,
    Colors.blueAccent,
  ];

  bool isSorted(var blockList) {
    var n = blockList.length;
    while (--n > 1) {
      if (blockList[n]["value"] < blockList[n - 1]["value"]) return false;
      return true;
    }
  }

  void shuffle() {
    var n = _blockList.length;
    for (int i = 0; i < n; i++) {
      var temp = _blockList[i];
      var rand = Random().nextInt(36);
      _blockList[i] = _blockList[rand];
      _blockList[rand] = temp;
    }
    if (isSorted(_blockList)) shuffle();
  }

  void shuffleRule() {
    var n = _blockRule.length;
    for (int i = 0; i < n; i++) {
      var temp = _blockRule[i];
      var rand = Random().nextInt(4);
      _blockRule[i] = _blockRule[rand];
      _blockRule[rand] = temp;
    }
  }

  getBlockList() => _blockList;
  getBlockRule() => _blockRule;

  getTimer() => _timer;

  setTimer(int timer) => _timer = timer;

  Future<void> incrementTimer() {
    Future.delayed(Duration(seconds: 1), () {
      _timer++;
      notifyListeners();
    });
  }
}
