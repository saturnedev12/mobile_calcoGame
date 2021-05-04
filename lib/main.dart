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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Game game = new Game();
  Map quiz;
  String mresponse;// = game.getQuiz();
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
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            //question
            Container(
              color: Colors.green,
              height: 200,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${quiz['quiz']} ?",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                    ),
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
              child:Text('$mresponse'),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.red,
              ),
            ),
            //keyboard
            Column(
              children: [
                Container(
                  color: Colors.blue,
                  width: double.infinity,
                  height: 200,
                  child: GridView.count(
                    primary: false,
                    padding: EdgeInsets.all(0),
                    crossAxisCount: 5,
                    children: [
                      for(int i =0; i <10; i++)
                        InkWell(
                          child: Container(
                            width: 20,
                            child: Text('$i'),
                            color: Colors.orange,
                          ),
                          onTap: (){
                            print('$i');
                            setState(() {
                              mresponse += '$i';
                            });
                          },
                        ),
                      InkWell(
                        child: Container(
                          width: 20,
                          child: Text('delete'),
                          color: Colors.red,
                        ),
                        onTap: (){
                          ;
                          setState(() {
                            mresponse = mresponse.substring(0,mresponse.length-1);
                            print(mresponse);
                          });
                        },
                      ),
                    ],
                  ),
                ),

                // ignore: deprecated_member_use
                RaisedButton(
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      child: Center(child: Text('valider')),
                    ),
                  color: Colors.greenAccent,
                  onPressed: (){
                      print(game.checkResponse(int.parse(mresponse), quiz['response']));
                      showAlertDialog(context,game.checkResponse(int.parse(mresponse), quiz['response']));
                      },
                  ),

              ],
            ),

          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
