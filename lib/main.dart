// @dart=2.9
import 'package:flutter/services.dart';
import 'package:Presente/utilities/count_up.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:Presente/utilities/constants.dart';
import 'package:Presente/info.dart';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int inhaleCount = 5;
  int holdCount = 2;
  int exhaleCount = 5;
  int holdCount2 = 2;
  int countDown = 0;

  int holdEmptyCount = 5;
  double sideLength = 100;
  Duration duration = Duration(milliseconds: 1000);
  Color color = Colors.blue;
  bool stopBreathing = true;
  String tapText = 'Toca para inspirar';
  String stageText = '';
  String holdStat1 = 'Permaneciste en presencia por:';
  String holdStat2 = 'segundos';
  String tapStat1 = 'Respiraste';
  String tapStat2 = 'veces';
  bool alertZeroTime = false;
  bool _visibleBreathingText = false;
  bool _visiblePressingText = false;
  bool _visibleInstructionsText = true;
  bool _visible = false;
  bool _showBottomSheet = true;
  bool _sound = false;
  bool _vibrate = false;
  bool _play = false;
  bool alertBreathing = false;


  int start = 1;
  bool stopTimer = false;
  bool stopBreathingTimer = false;
  int roundNumber = 0;

  Timer timerInhale = Timer(Duration.zero, () => {});
  Timer timerHold = Timer(Duration.zero, () => {});
  Timer timerHold2 = Timer(Duration.zero, () => {});
  Timer timerExhale = Timer(Duration.zero, () => {});
  Timer timmierTotal = Timer(Duration.zero, () => {});

  stopAllTimer() {
    //Mark:- cancel all timer;
    print("will cancel all timers ");
    setState(() {
      duration = Duration(milliseconds: 0);
      sideLength == 0.0;
      roundNumber = 0;
    });

    timerHold2.cancel();
    timerInhale.cancel();
    timerHold.cancel();
    timerExhale.cancel();
  }

  inHale() {
    //Mark:- add timer to hold the pressing
    // stopAllTimer();
    timerHold2.cancel();
    if (inhaleCount > 0) {
      _sound ? playSound() : null;
    }    _vibrate ? Vibration.vibrate(duration: 10, pattern: [100,100], intensities: [150]) : null;

    setState(() {
      countDown = inhaleCount;
      roundNumber++;
      color = kInhaleColor;
      stageText = ' Inhala ';
      sideLength == 100 ? sideLength = 150 : sideLength = 100;
      duration = Duration(milliseconds: inhaleCount * 1000);
      sideLength == 100
          ? tapText = 'Toca para inspirar'
          : tapText = 'Toca para exhalar';
      print(tapText);
    });
    print(" hale in " + DateTime.now().toString());
    timerInhale = Timer.periodic(
        Duration(seconds: inhaleCount),
            (timer) => {
          holdInhole(),
            });
  }

  holdInhole() {
    //Mark:- add timer to hold the pressing
    timerInhale.cancel();
    if (holdCount > 0) {
      _sound ? playSound() : null;
    }    _vibrate ? Vibration.vibrate(duration: 10, pattern: [100,0], intensities: [150]) : null;

    setState(() {
      countDown = holdCount;
      color = kHoldColor;
      stageText = 'Retiene';
    });
    print(" hold in " + DateTime.now().toString());
    timerHold = Timer.periodic(
      Duration(seconds: holdCount),
          (Timer) => {
        exhale(),

          },
    );
  }

  exhale() {
    //Mark:- start timer to exhale
    //Mark:- add timer to hold the pressing
    timerHold.cancel();
    if (exhaleCount > 0) {
      _sound ? playSound() : null;
    }    _vibrate ? Vibration.vibrate(duration: 10, pattern: [100,0], intensities: [150]) : null;

    setState(() {
      countDown = exhaleCount;

      color = kExhaleColor;
      stageText = ' Exhala ';
     // stopTimer = true;
      sideLength == 100 ? sideLength = 150 : sideLength = 100;
      duration = Duration(milliseconds: exhaleCount * 1000);
      sideLength == 100
          ? tapText = 'Toca para inhalar'
          : tapText = 'Toca para exhalar';
      print(tapText);
    });
    print(" exhale in " + DateTime.now().toString());
    timerExhale = Timer.periodic(
      Duration(seconds: exhaleCount),
          (Timer) => {
        holdExhale(),
          },
    );
  }

  holdExhale() {
    //Mark:- start hold after exhale
    timerExhale.cancel();
    if (holdCount2 > 0) {
      _sound ? playSound() : null;
    }
    _vibrate ? Vibration.vibrate(duration: 10, pattern: [100,0], intensities: [150]) : null;


    setState(() {
      countDown = holdCount2;
      color = kHoldColor;
      stageText = 'Sostiene';
    });
    print("hold 2 " + DateTime.now().toString());
    timerHold2 = Timer.periodic(
      Duration(seconds: holdCount2),
          (timer) => {
        inHale(),
      },
    );
  }



  void playSound() {
   final player = AudioCache();
   player.play('bell-sound.mp3');
  }

  // void playBreatheSound() {
  //  final player = AudioCache();
  //  player.play('bell.mp3');
  // }

  // void _toggleVisibility() {
  //   setState(() {
  //     _visible = !_visible;
  //   });
  // }

  // void _toggleTimerTotal() {
  //   setState(() {
  //     stopBreathing = !stopBreathing;
  //   });
  // }

  void startTimer() {
    Timer _timer;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timerPressing) {
        if (stopTimer == true) {
          setState(() {
            timerPressing.cancel();
          });
        } else {
          setState(() {
            start++;
            _vibrate ? Vibration.vibrate(duration: 10, pattern: [100,0], intensities: [20]) : null;
          });
        }
      },
    );
  }

  void StartBreathing() {
    if (stopBreathingTimer == false) {
      setState(() {
        stopBreathingTimer = true;
        _visibleBreathingText = true;
        _visibleInstructionsText = false;
      });
      inHale();
    } else {
      setState(() {
        stopBreathingTimer = false;
        _visibleBreathingText = false;
        _visibleInstructionsText = true;
        sideLength = 100;
        color = kPrimaryBlueColor;
        stageText = "";
        stopAllTimer();
      });
    }
  }

  void StartPressing() {
    _vibrate ? Vibration.vibrate(duration: 10, pattern: [100,0], intensities: [20]) : null;
    setState(() {
      _visiblePressingText = true;
      _visibleInstructionsText = false;
      stopTimer = false;
      sideLength == 100
          ? sideLength = 150
          : sideLength = 100;
      duration = Duration(milliseconds: 500);
    });
    color = kSecondaryBlueColor;
    startTimer();
  }

  void StopPressing() {
    setState(() {
      _visiblePressingText = false;
      _visibleInstructionsText = true;
      stopTimer = true;
      sideLength == 100
          ? sideLength = 150
          : sideLength = 100;
      duration = Duration(milliseconds: 300);
    });
    color = kPrimaryBlueColor;
  }

  @override
  void initState() {
    super.initState();
    Timer timerInhale;
    Timer timerHold;
    Timer timerExhale;
    Timer timerTotal;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryBlueColor,
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      home: Builder(
          builder: (context) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Presente', style: kTitleTextStyle),
              leading: IconButton(
                onPressed: () {Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Info()),
                );},
                icon: Icon(Icons.info, color: kSecondaryGrayColor),
              ),
              actions: [
                IconButton(
                    icon: _sound
                        ? Icon(Icons.volume_up, color: kSecondaryGrayColor)
                        : Icon(
                      Icons.volume_off,color: kSecondaryGrayColor),
                    onPressed: () {
                      setState(() {
                        _sound = !_sound;
                      });
                    }),
     ]
        ),
          body: SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: alertZeroTime,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Todas las etapas no pueden ser 0',
                              style: kLabelTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _visibleInstructionsText,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              'Presiona dos veces\npara iniciar/pausar la respiración\n\nMantén presionado\npara estar en presencia',
                              style: kLabelTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _visibleBreathingText,
                          child: Text(
                            'Rondas completadas:',
                            style: kPresserTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Visibility(
                          visible: _visiblePressingText,
                          child: Text(
                            'Segundos en presencia:',
                            style: kPresserTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Visibility(
                          visible: _visibleBreathingText,
                          child: Text(
                            roundNumber.toString(),
                            style: kPresserNumberStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Visibility(
                          visible: _visiblePressingText,
                          child: Text(
                            start.toString(),
                            style: kPresserNumberStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Material(
                        color: color,
                        borderRadius: BorderRadius.circular(100.0),
                        child: AnimatedContainer(
                          height: sideLength,
                          width: sideLength,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            color: Colors.transparent,
                          ),
                          duration: duration,
                          curve: Curves.easeInOut,
                          child: Center(
                              child: GestureDetector(
                                onDoubleTap: () {
                                  if (inhaleCount + holdCount + exhaleCount + holdCount2 > 0) {
                                    StartBreathing();
                                    setState(() {
                                      alertZeroTime = false;
                                      alertBreathing = !alertBreathing;
                                    });
                                  } else {
                                    setState(() {
                                      _visibleBreathingText = false;
                                      _visibleInstructionsText = false;
                                      alertZeroTime = true;
                                    });
                                  }
                                },
                                child: GestureDetector(
                                  onLongPressStart: (_) {alertBreathing ? null : StartPressing();},
                                  onLongPressEnd: (_) {alertBreathing ? null : StopPressing();},
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      primary: kAccentBlueColor,
                                      padding: EdgeInsets.all(20),),
                                    onPressed: () {
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        _visibleBreathingText
                                            ? Countup(
                                          begin: countDown.toDouble()-countDown.toDouble(),
                                          end: countDown.toDouble(),
                                          duration: Duration(seconds: countDown),
                                          separator: ',',
                                          style: TextStyle(
                                            fontSize: 25,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.clip,
                                          semanticsLabel: '',
                                          key: Key(countDown.toString() +
                                              DateTime.now().toString()),
                                        )
                                            : Text(""),
                                        Text('$stageText', style: kSmallTextStyle),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: ElevatedButton(
                        child: Text(
                          'Configurar respiración',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            _showBottomSheet = true;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: _showBottomSheet
              ? BottomSheet(
              enableDrag: true,
              elevation: 50,
              backgroundColor: Colors.white,
              onClosing: () {
                // Do something
              },
              builder: (BuildContext ctx) => Container(
                width: double.infinity,
                height: 270,
                alignment: Alignment.center,
                child: Column(
                  children: [
                    SizedBox(height:10.0),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Inhalar',
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
                                  onPressed: () {
                                    if (inhaleCount != 0) {
                                    setState(() => inhaleCount--);
                                  }},
                                      ),
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
                            'Retener',
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
                                onPressed: () {
                                  if (holdCount != 0) {
                                    setState(() => holdCount--);
                                  }},),
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
                            'Exhalar',
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
                                onPressed: () {
                                  if (exhaleCount != 0) {
                                    setState(() => exhaleCount--);
                                  }},),
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
                            'Sostener',
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
                                onPressed: () {
                                  if (holdCount2 != 0) {
                                    setState(() => holdCount2--);
                                  }},),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  holdCount2.toString()+" sec",
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
                                      setState(() => holdCount2++)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //ElevatedButton.icon(
                        //  icon: _play
                        //      ? Icon(Icons.pause, color: kPrimaryGrayColor)
                        //      : Icon(
                        //      Icons.play_arrow,color: kPrimaryGrayColor),
                        //  onPressed: () {
                        //    StartBreathing();
                        //    setState(() {
                        //      _play = !_play;
                        //    });
                        //  },
                        //  label: _play
                        //      ? Text('Pausar')
                        //      : Text(' Iniciar'),
                        //  style: ElevatedButton.styleFrom(
                        //      primary: _play
                        //      ? Colors.red
                        //      : Colors.green),
                        // ),
                        // SizedBox(width:20.0),
                        ElevatedButton(
                          child: Text(
                            'Cerrar',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              _showBottomSheet = false;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height:10.0),


                  ],
                ),
              ))
              : null,
        ),
      ),
    );
  }
}