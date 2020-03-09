import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:tubes_sda/providers/theme-changer.dart';
import 'package:tubes_sda/screens/components/first-logo.dart';
import 'package:tubes_sda/screens/components/second-logo.dart';
import 'package:tubes_sda/screens/components/timer-widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:provider/provider.dart';
import 'package:tubes_sda/screens/game-over-screen.dart';
import '../providers/game-model.dart';

class First6Screen extends StatefulWidget {
  @override
  _First6ScreenState createState() => _First6ScreenState();
}

class DisjointSet {
  List<int> rank, parent = [];
  int n;
  var random = Random();

  DisjointSet(int n) {
    rank = List<int>(n);
    parent = List<int>(n);
    this.n = n;
    // print('nilai n: ${this.n}');
    makeSet();
  }

  void makeSet() {
    print('make set:');
    for (int i = 0; i < this.n; i++) {
      parent[i] = i;
      // print(parent[i]);
    }
    for (int i = 0; i < this.n; i++) {
      rank[i] = 0;
      // print(rank[i]);
    }
  }

  int find(int x) {
    if (parent[x] != x) {
      parent[x] = find(parent[x]);
    }
    return parent[x];
  }

  void union(int x, int y) {
    // print('x: $x | y: $y');
    int xRoot = find(x);
    int yRoot = find(y);
    // print('x: $xRoot | y: $yRoot');
    if (xRoot == yRoot) return;
    if (rank[xRoot] < rank[yRoot]) {
      parent[xRoot] = yRoot;
    } else if (rank[yRoot] < rank[xRoot]) {
      parent[yRoot] = xRoot;
    } else {
      parent[yRoot] = xRoot;
      rank[xRoot] = rank[xRoot] + 1;
    }
  }

  void setRandom() {
    // union(1, 97);
    while (!check(1, 97)) {
      var x = random.nextInt(100);
      int x1 = x + 1;
      int x2 = x - 1;
      int x3 = x + 10;
      int x4 = x - 10;
      int jml1 = 0;
      int jml2 = 0;
      var check1 = check(x1, 1);
      var check2 = check(x2, 1);
      var check3 = check(x3, 1);
      var check4 = check(x4, 1);
      var choco1 = check(x1, 97);
      var choco2 = check(x2, 97);
      var choco3 = check(x3, 97);
      var choco4 = check(x4, 97);
      if (check1) jml1++;
      if (check2) jml1++;
      if (check3) jml1++;
      if (check4) jml1++;
      if (choco1) jml2++;
      if (choco2) jml2++;
      if (choco3) jml2++;
      if (choco4) jml2++;
      if ((check1 || check2 || check3 || check4) && (jml1 == 1)) {
        union(x, 1);
      } else if ((choco1 || choco2 || choco3 || choco4) && (jml2 == 1)) {
        union(x, 97);
      }
    }
  }

  bool check(int x, int y) {
    try {
      if (find(x) == find(y)) return true;
    } catch (e) {
      return false;
    }
    return false;
  }

  void reset() {
    rank = List<int>(n);
    parent = List<int>(n);
    makeSet();
  }
}

class _First6ScreenState extends State<First6Screen> {
  var blockClickStatus = List<bool>.generate(36, (index) => false);
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
    final key = 'bestTime6';
    setState(() {
      bestTime = prefs.getInt(key) ?? 0;
      print(prefs.getInt(key));
    });
  }

  _save() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'bestTime6';
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
    // final gameModel = Provider.of<GameModel>(context);
    // gameModel.shuffle();
    // gameModel.shuffleRule();
    // var blockList = gameModel.getBlockList();
    // var blockRule = gameModel.getBlockRule();
    var blockList = _blockList;
    var blockRule = _blockRule;

    final theme = Provider.of<ThemeChanger>(context);

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
              if (countDestroy == 36) {
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
          'Mode 6x6',
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
              itemCount: 36,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
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
          (countDestroy == 36
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
