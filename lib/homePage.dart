import 'package:flutter/material.dart';
import 'package:calcule_speed/gamePage.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get onPressed => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                'CALCULE SPEED',
                style: GoogleFonts.mcLaren(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Text('test your brain skills'),
              // ignore: deprecated_member_use
              RaisedButton(
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('start game',
                        style: TextStyle(
                          fontFamily: 'chandas',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,

                        ),
                      ),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: Colors.greenAccent,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GamePage()));
                  }),

              Text(
                '© 2021 Saturne_Dev | free softtware',
                style: GoogleFonts.dmSerifDisplay(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
