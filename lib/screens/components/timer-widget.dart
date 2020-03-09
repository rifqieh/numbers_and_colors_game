import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/game-model.dart';

class TimerWidget extends StatefulWidget {
  var isFinish;
  Function setTimer;
  TimerWidget({this.isFinish, this.setTimer});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int time = 0;
  Timer _timer;
  var oneSec = Duration(seconds: 1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(time);

    _timer = Timer.periodic(oneSec, (timer) {
      if (widget.isFinish == true) {
        widget.setTimer(time);
        timer.cancel();
      } else {
        setState(() {
          time++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child:
          Text('Timer: $time s', style: TextStyle(fontWeight: FontWeight.w600)),
    );
  }
}
