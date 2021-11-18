import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shake/shake.dart';

void main() {
  runApp(const Magic8BallApp());
}

class Magic8BallApp extends StatefulWidget {
  const Magic8BallApp({Key? key}) : super(key: key);

  @override
  _Magic8BallAppState createState() => _Magic8BallAppState();
}

class _Magic8BallAppState extends State<Magic8BallApp> {
  List answers = [
    'Да',
    'Нет',
    'Возможно',
    'Никаких сомнений',
    'Звезды говорят да',
  ];

  int answerNumber = 0;

  bool visible = false;

  @override
  void initState() {
    super.initState();
    ShakeDetector shakeDetector = ShakeDetector.autoStart(onPhoneShake: () {
      setState(() {
        answerNumber = Random().nextInt(answers.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: const Text(
            'Спроси меня',
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            generateRandomAnswer();
          },
          child: Stack(
            children: [
              const Center(
                child: Image(
                  image: AssetImage(
                    'assets/magic_eight_ball.png',
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 100,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 1000),
                    opacity: visible ? 1.0 : 0.0,
                    child: Text(
                      answers[answerNumber],
                      style: TextStyle(color: Colors.blue),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void generateRandomAnswer() {
    setState(() {
      visible = false;
    });

    final player = AudioCache();
    player.play('magic_music.mp3');

    Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        answerNumber = Random().nextInt(answers.length);
        visible = true;
      });
    });
  }
}
