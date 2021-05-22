import 'package:flutter/material.dart';
import 'package:calcule_speed/game/game.dart';
import 'package:flutter/painting.dart';
import 'package:calcule_speed/game/modal.dart';
import 'dart:async';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  //variables
  int score = 0;
  int count = 15;
  Game game = new Game();
  Map quiz;
  String mresponse;
  chrono() {}
  Timer _timer;
  int _start = 10;
  bool iplay = true;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (count == 0) {
          setState(() {
            _showDialog(timer);
          });
        } else {
          setState(() {
            count--;
          });
        }
      },
    );
  }

  restartGame() {
    _timer.cancel();
    setState(() {
      game = new Game();
      quiz = game.getQuiz();
      mresponse = '';
      score = 0;
      count = 15;
      iplay = true;
    });
    startTimer();
  }

  //check response and show modal if response is false
  _showDialog(Timer timer) async {
    // ignore: unrelated_type_equality_checks
    if (mresponse == '') mresponse = '0';
    await Future.delayed(Duration(milliseconds: 40));
    if (game.checkResponse(int.parse(mresponse), quiz['response'])) {
      setState(() {
        game = new Game();
        quiz = game.getQuiz();
        mresponse = '';
        score++;
        count = 15;
      });
    } else {
      iplay = false;
      timer.cancel();
      showAlertDialog(
          context,
          game.checkResponse(int.parse(mresponse), quiz['response']),
          quiz['response'],
          score,
          restartGame);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    quiz = game.getQuiz();
    mresponse = '';
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'score: $score',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.replay_outlined,
                size: 22,
              ),
              onPressed: () {
                restartGame();
              })
        ],
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //question
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFEEC26F),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 120,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${quiz['quiz']} ?",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            //chrono
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Row(
                    children: [
                      Text('$count'),
                      Icon(Icons.timer),
                    ],
                  ),
                )
              ],
            ),
            //myresponse
            Container(
              child: Text(
                '$mresponse',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              padding: EdgeInsets.all(7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black12,
              ),
            ),
            //keyboard
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 6),
                  //color: Colors.blue,
                  width: double.infinity,
                  height: 215,
                  child: GridView.count(
                    primary: false,
                    padding: EdgeInsets.all(0),
                    crossAxisCount: 5,
                    children: [
                      for (int i = 0; i < 10; i++)
                        InkWell(
                          child: Container(
                            width: 20,
                            margin: EdgeInsets.all(3),
                            child: Center(
                              child: Text(
                                '$i',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(60),
                            ),
                          ),
                          onTap: () {
                            print('$i');
                            if (iplay)
                              setState(() {
                                if (mresponse.length < 6) mresponse += '$i';
                              });
                          },
                        ),
                      InkWell(
                        child: Container(
                          //margin: EdgeInsets.only(top: 13, bottom: 13),
                          margin: EdgeInsets.all(3),
                          width: 20,
                          child: Center(
                            child: Text(
                              '-',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                        onTap: () {
                          print('-');
                          if (iplay)
                            setState(() {
                              if (mresponse.length < 6) mresponse += '-';
                            });
                        },
                      ),
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.only(top: 13, bottom: 13),
                          width: 30,
                          child: Center(
                            child: Text(
                              'delete',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red,
                          ),
                        ),
                        onTap: () {
                          if (iplay)
                            setState(() {
                              mresponse =
                                  mresponse.substring(0, mresponse.length - 1);
                              print(mresponse);
                            });
                        },
                      ),
                    ],
                  ),
                ),

                // ignore: deprecated_member_use
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 30,
          ),
          backgroundColor: Colors.greenAccent,
          onPressed: () {
            if (iplay) _showDialog(_timer);
          }),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
