// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:quizzler/quiz.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizz = QuizBrain();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.grey.shade900,
            // ignore: prefer_const_constructors
            body: SafeArea(
                // ignore: prefer_const_constructors
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              // ignore: prefer_const_constructors
              child: Quickpage(),
            ))));
  }
}

class Quickpage extends StatefulWidget {
  const Quickpage({Key? key}) : super(key: key);

  @override
  _QuickpageState createState() => _QuickpageState();
}

class _QuickpageState extends State<Quickpage> {
  List<Icon> scoreKeeper = [];
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizz.getCorrectAnswer();

    setState(() {
      if (quizz.isFinished() == true) {
        Alert(
                context: context,
                title: 'Finished!',
                desc: 'You\'ve reached the end of the quiz')
            .show();

        quizz.reset();
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          // print('user got it right.');
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          // print('user got it wrong');
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }

        quizz.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ignore: prefer_const_constructors
        Expanded(
            flex: 7,
            // ignore: prefer_const_constructors
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              // ignore: prefer_const_constructors
              child: Center(
                child: Text(
                  quizz.getQuestionText(),
                  style: TextStyle(fontSize: 25.0, color: Colors.white),
                ),
              ),
            )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          // ignore: deprecated_member_use
          child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              onPressed: () {
                checkAnswer(true);
                // scoreKeeper.add(Icon(Icons.check, color: Colors.green));
              },
              child: const Text('True',
                  style: TextStyle(color: Colors.white, fontSize: 20))),
        )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(15.0),
          // ignore: deprecated_member_use
          child: FlatButton(
              textColor: Colors.white,
              color: Colors.red,
              onPressed: () {
                checkAnswer(false);
              },
              child: const Text('False',
                  style: TextStyle(color: Colors.white, fontSize: 20))),
        )),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
