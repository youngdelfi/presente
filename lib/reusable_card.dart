import 'package:flutter/material.dart';
import 'package:Presente/main.dart';
import 'package:Presente/utilities/constants.dart';
import 'package:Presente/guided.dart';

import 'dart:async';
import 'dart:io';


class BottomModal extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          physics: ClampingScrollPhysics(),
          child: BreathingSettings( scrollController ),

        );
      },
    );
  }
}

class BreathingSettings extends StatefulWidget {
  final ScrollController scrollController;

  static int inhaleCount = inhaleCount;
  static int exhaleCount = exhaleCount;
  static int holdCount = holdCount;
  static int holdEmptyCount = holdEmptyCount;
  static double sideLength = sideLength;


  BreathingSettings( this.scrollController );
  @override
  _BreathingSettingsState createState() => _BreathingSettingsState();
}

class _BreathingSettingsState extends State<BreathingSettings> {

  int inhaleCount = 1;
  int holdCount = 1;
  int exhaleCount = 1;
  int holdEmptyCount = 5;
  int _counter = 0;
  double sideLength = 100;
  Duration duration = Duration(milliseconds: 1000);
  Color color = Colors.blue;
  bool stopBreathing = false;
  String tapText = 'Toca para inhalar';
  String stageText = 'Inhala';
  String holdStat1 = 'Permaneciste en presencia por:';
  String holdStat2 = 'segundos';
  String tapStat1 = 'Respiraste';
  String tapStat2 = 'veces';


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          RawMaterialButton(
              elevation: 10.0,
              shape: CircleBorder(),
              fillColor: Colors.blue,
              child: Icon(Icons.keyboard_arrow_up, color: kPrimaryGrayColor),
              constraints: BoxConstraints.tightFor(
                width: 50.0,
                height: 50.0,
              ),
              onPressed: () {
              }
                  ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Inhale',
                  style: kLabelTextStyle,
                ),
                Row(
                  children: [
                    RawMaterialButton(
                        elevation: 0.0,
                        shape: CircleBorder(side: BorderSide(color: kPrimaryGrayColor)),
                        fillColor: Colors.white,
                        child: Icon(Icons.remove, color: kPrimaryBlueColor),
                        constraints: BoxConstraints.tightFor(
                          width: 30.0,
                          height: 30.0,
                        ),
                        onPressed: () =>
                            setState(() => inhaleCount--)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        inhaleCount.toString()+" sec",
                        style: kNumberTextStyle,
                      ),
                    ),
                    RawMaterialButton(
                        elevation: 0.0,
                        shape: CircleBorder(side: BorderSide(color: kPrimaryGrayColor)),
                        fillColor: Colors.white,
                        child: Icon(Icons.add, color: kPrimaryBlueColor),
                        constraints: BoxConstraints.tightFor(
                          width: 30.0,
                          height: 30.0,
                        ),
                        onPressed: () =>
                            setState(() => inhaleCount++)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Hold',
                  style: kLabelTextStyle,
                ),
                Row(
                  children: [
                    RawMaterialButton(
                        elevation: 0.0,
                        shape: CircleBorder(side: BorderSide(color: kPrimaryGrayColor)),
                        fillColor: Colors.white,
                        child: Icon(Icons.remove, color: kPrimaryBlueColor),
                        constraints: BoxConstraints.tightFor(
                          width: 30.0,
                          height: 30.0,
                        ),
                        onPressed: () =>
                            setState(() => holdCount--)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        holdCount.toString()+" sec",
                        style: kNumberTextStyle,
                      ),
                    ),
                    RawMaterialButton(
                        elevation: 0.0,
                        shape: CircleBorder(side: BorderSide(color: kPrimaryGrayColor)),
                        fillColor: Colors.white,
                        child: Icon(Icons.add, color: kPrimaryBlueColor),
                        constraints: BoxConstraints.tightFor(
                          width: 30.0,
                          height: 30.0,
                        ),
                        onPressed: () =>
                            setState(() => holdCount++)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Exhale',
                  style: kLabelTextStyle,
                ),
                Row(
                  children: [
                    RawMaterialButton(
                        elevation: 0.0,
                        shape: CircleBorder(side: BorderSide(color: kPrimaryGrayColor)),
                        fillColor: Colors.white,
                        child: Icon(Icons.remove, color: kPrimaryBlueColor),
                        constraints: BoxConstraints.tightFor(
                          width: 30.0,
                          height: 30.0,
                        ),
                        onPressed: () =>
                            setState(() => exhaleCount--)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        exhaleCount.toString()+" sec",
                        style: kNumberTextStyle,
                      ),
                    ),
                    RawMaterialButton(
                        elevation: 0.0,
                        shape: CircleBorder(side: BorderSide(color: kPrimaryGrayColor)),
                        fillColor: Colors.white,
                        child: Icon(Icons.add, color: kPrimaryBlueColor),
                        constraints: BoxConstraints.tightFor(
                          width: 30.0,
                          height: 30.0,
                        ),
                        onPressed: () =>
                            setState(() => exhaleCount++)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Hold',
                  style: kLabelTextStyle,
                ),
                Row(
                  children: [
                    RawMaterialButton(
                        elevation: 0.0,
                        shape: CircleBorder(side: BorderSide(color: kPrimaryGrayColor)),
                        fillColor: Colors.white,
                        child: Icon(Icons.remove, color: kPrimaryBlueColor),
                        constraints: BoxConstraints.tightFor(
                          width: 30.0,
                          height: 30.0,
                        ),
                        onPressed: () =>
                            setState(() => holdEmptyCount--)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        holdEmptyCount.toString()+" sec",
                        style: kNumberTextStyle,
                      ),
                    ),
                    RawMaterialButton(
                        elevation: 0.0,
                        shape: CircleBorder(side: BorderSide(color: kPrimaryGrayColor)),
                        fillColor: Colors.white,
                        child: Icon(Icons.add, color: kPrimaryBlueColor),
                        constraints: BoxConstraints.tightFor(
                          width: 30.0,
                          height: 30.0,
                        ),
                        onPressed: () =>
                            setState(() => holdEmptyCount++)),
                  ],
                ),
              ],
            ),
          ),
        ],

      ),
    );
  }
}


