import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tubes_sda/screens/components/first-logo.dart';
import '../providers/theme-changer.dart';
import 'package:tubes_sda/screens/components/second-logo.dart';
import 'package:tubes_sda/screens/components/timer-widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:provider/provider.dart';
import 'package:tubes_sda/screens/game-over-screen.dart';
import '../providers/game-model.dart';

class First4Screen extends StatefulWidget {
  @override
  _First4ScreenState createState() => _First4ScreenState();
}

class _First4ScreenState extends State<First4Screen> {
  var blockClickStatus = List<bool>.generate(16, (index) => false);
  var firstSelectedIndex;
  var secondSelectedIndex;
  var countDestroy = 0;
  var countSelected = 0;
  var selectedBlockIndex = [];
  var isFinish = false;
  var _time = 0;
  int bestTime;
  AudioPlayer player;

  Future loadSound() async {
    // AudioPlayer player = await AudioCache().loop('loose.mp3');
  }

  _read() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'bestTime4';
    setState(() {
      bestTime = prefs.getInt(key) ?? 0;
      print(prefs.getInt(key));
    });
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'bestTime4';
    prefs.setInt(key, _time);
  }

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
      var rand = Random().nextInt(16);
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

  var _blockList = [
    {"color": Colors.redAccent, "value": 1},
    {"color": Colors.redAccent, "value": 2},
    {"color": Colors.redAccent, "value": 3},
    {"color": Colors.redAccent, "value": 4},
    {"color": Colors.amberAccent, "value": 1},
    {"color": Colors.amberAccent, "value": 2},
    {"color": Colors.amberAccent, "value": 3},
    {"color": Colors.amberAccent, "value": 4},
    {"color": Colors.greenAccent, "value": 1},
    {"color": Colors.greenAccent, "value": 2},
    {"color": Colors.greenAccent, "value": 3},
    {"color": Colors.greenAccent, "value": 4},
    {"color": Colors.blueAccent, "value": 1},
    {"color": Colors.blueAccent, "value": 2},
    {"color": Colors.blueAccent, "value": 3},
    {"color": Colors.blueAccent, "value": 4},
  ];

  getBlockList() => _blockList;
  getBlockRule() => _blockRule;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shuffle();
    _read();
    loadSound();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    // gameModel.shuffle();
    // gameModel.shuffleRule();
    // var blockList = gameModel.getBlockList();
    // var blockRule = gameModel.getBlockRule();
    var blockList = _blockList;
    var blockRule = _blockRule;

    Future breakSound() async {
      if (theme.getSoundStatusId() == 0)
        player = await AudioCache().play('break.wav');
    }

    selectBlock(var index, var status) {
      // cek jika belum diclik
      if (blockClickStatus[index] == false) {
        if (countSelected == 2) {
          return false;
        }
        //belum ada yang diklik
        if (countSelected == 0) {
          setState(() {
            firstSelectedIndex = index;
            blockClickStatus[index] = true;
            countSelected++;
          });
        }
        //yang diklik baru 1
        else if (countSelected == 1) {
          // jika valuenya sama -> hancurkan
          if (blockList[index]["value"] ==
              blockList[firstSelectedIndex]["value"]) {
            setState(() {
              blockList[index]["color"] = Colors.white;
              blockList[firstSelectedIndex]["color"] = Colors.white;
              blockList[index]["value"] = null;
              blockList[index]["value"] = null;
              blockClickStatus[index] = null;
              blockClickStatus[firstSelectedIndex] = null;
              countSelected = 0;
              countDestroy += 2;
              breakSound();
              if (countDestroy == 16) {
                isFinish = true;
              }
            });
            return false;
          } else {
            setState(() {
              secondSelectedIndex = index;
              blockClickStatus[index] = true;
              countSelected++;
              return false;
            });
          }
        }
      } else {
        if (countSelected == 2) {
          if (index == firstSelectedIndex) {
            setState(() {
              firstSelectedIndex = secondSelectedIndex;
            });
          }
          setState(() {
            secondSelectedIndex = null;
            countSelected--;
            blockClickStatus[index] = false;
          });
        } else if (countSelected == 1) {
          setState(() {
            countSelected--;
            firstSelectedIndex = null;
            blockClickStatus[index] = false;
          });
        }
      }
    }

    matching() {}

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mode 4x4',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TimerWidget(
                  isFinish: isFinish,
                  setTimer: (var time) {
                    setState(() {
                      _time = time;
                      if (_time <= bestTime ||
                          (bestTime == 0 || bestTime == null)) {
                        bestTime = _time;
                        _save();
                      }
                    });
                  },
                ),
                Text(
                  'Best Time: $bestTime s',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          // Center(
          //   child: Text(
          //     'Rules',
          //     style: TextStyle(fontWeight: FontWeight.w600),
          //   ),
          // ),
          FirstLogo(),
          Expanded(
            child: GridView.builder(
              primary: false,
              padding: EdgeInsets.all(20),
              itemCount: 16,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (context, i) {
                return Block(
                  index: i,
                  color: blockList[i]["color"],
                  value: blockList[i]["value"],
                  clickFunction: (var index, var status) {
                    return selectBlock(index, status);
                  },
                  isClick: blockClickStatus[i],
                );
              },
            ),
          ),
          (countDestroy == 16
              ? FinishCard(time: _time, bestTime: bestTime)
              : Container()),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}

class FinishCard extends StatelessWidget {
  var time;
  var bestTime;
  FinishCard({this.time, this.bestTime});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => GameOverScreen(
                      mode: '4x4',
                      time: time,
                      bestTime: bestTime,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.blueAccent),
        width: 300,
        height: 70,
        child: Center(
          child: Text(
            'SEE YOUR RESULT',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class Block extends StatefulWidget {
  var index;
  var color;
  var value;
  var clickFunction;
  var isClick;

  Block({this.index, this.color, this.value, this.clickFunction, this.isClick});

  @override
  _BlockState createState() => _BlockState();
}

class _BlockState extends State<Block> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.clickFunction(widget.index, widget.isClick);
        });
      },
      child: Card(
        color: (widget.isClick == true ? Colors.blueGrey : widget.color),
        child: Container(
          padding: EdgeInsets.all(8),
          child: Container(
            color: widget.color,
            child: Center(
                child: Text(
              '${widget.value}',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            )),
          ),
        ),
      ),
    );
  }
}
