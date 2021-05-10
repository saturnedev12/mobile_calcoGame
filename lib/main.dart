import 'package:flutter/material.dart';
import 'package:calcule_speed/game/game.dart';
import 'package:flutter/painting.dart';
import 'package:calcule_speed/game/modal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int score = 0;
  Game game = new Game();
  Map quiz;
  String mresponse; // = game.getQuiz();
  @override
  void initState() {
    // TODO: implement initState
    quiz = game.getQuiz();
    mresponse = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('score: $score'),
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
                      Text('5'),
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
                  height: 190,
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
                            setState(() {
                              if (mresponse.length < 4) mresponse += '$i';
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
                          setState(() {
                            if (mresponse.length < 4) mresponse += '-';
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
            print(game.checkResponse(int.parse(mresponse), quiz['response']));
            if (game.checkResponse(int.parse(mresponse), quiz['response'])) {
              setState(() {
                game = new Game();
                quiz = game.getQuiz();
                mresponse = '';
                score++;
              });
            } else {
              showAlertDialog(
                context,
                game.checkResponse(int.parse(mresponse), quiz['response']),
                quiz['response'],
                score,
              );
            }
          }),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

/*
  
// It starts paused
final timer = PausableTimer(Duration(seconds: 1), () => print('Fired!'));
timer.start();
timer.pause();
timer.start();
*/