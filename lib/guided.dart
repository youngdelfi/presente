import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holding_gesture/holding_gesture.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:Presente/utilities/constants.dart';
import 'package:Presente/main.dart';
import 'package:Presente/reusable_card.dart';
import 'package:Presente/round_icon_button.dart';
import 'package:Presente/guided.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:io';

class BreathingPattern extends StatefulWidget {
  @override
  _BreathingPatternState createState() => _BreathingPatternState();
}

class _BreathingPatternState extends State<BreathingPattern> {
  @override
  int inhaleCount = BreathingSettings.inhaleCount;
  int holdCount = BreathingSettings.holdCount;
  int exhaleCount = BreathingSettings.exhaleCount;
  int holdEmptyCount = BreathingSettings.holdEmptyCount;
  int _counter = 0;
  double sideLength = BreathingSettings.sideLength;
  Duration duration = Duration(milliseconds: 1000);
  Color color = Colors.blue;
  bool stopBreathing = false;
  String tapText = 'Toca para inhalar';
  String stageText = '';
  String holdStat1 = 'Permaneciste en presencia por:';
  String holdStat2 = 'segundos';
  String tapStat1 = 'Respiraste';
  String tapStat2 = 'veces';
  bool _visible = false;
  int start = 1;
  bool stopTimer = false;


  void runBreathingTimer() {
    Timer timerInhale;
    Timer timerHold;
    Timer timerExhale;
    Timer timerTotal;
    int totalDuration = inhaleCount + holdCount + exhaleCount + holdEmptyCount;

    int roundNumber = 0;

    timerTotal = Timer.periodic(Duration(
        seconds: inhaleCount + holdCount + exhaleCount + holdEmptyCount), (
        Timer t) {
      timerInhale = Timer(Duration(seconds: inhaleCount), () {
        setState(
              () {
            sideLength = 150;
            duration = Duration(seconds: inhaleCount);
            stageText = 'inhala';
          },
        );
        print("timer inhalado");
        timerExhale = Timer(Duration(seconds: exhaleCount), () {
          setState(
                () {
              sideLength = 100;
              duration = Duration(seconds: exhaleCount);
              stageText = 'exhala';
            },
          );
        });
        print("timer hold");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}