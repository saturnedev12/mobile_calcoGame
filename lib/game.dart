import 'dart:math';
import 'package:flutter/material.dart';
import 'package:calcule_speed/game/builder.dart';

class Game{
  Random rnd = new Random();
  int sizeListe, idop;
  List nbrs, operators=['+','-','*'];
  String quiz = "",op;
  Map<String, dynamic> getQuiz(){
    sizeListe = rnd.nextInt(3) + 2;
    nbrs = List(sizeListe);
    for(int i=0; i< sizeListe; i++){
      nbrs[i] = rnd.nextInt(10);
      idop = rnd.nextInt(operators.length);
      op = operators[idop];
      if(i == sizeListe-1) op = "";
      quiz = quiz + ' ${nbrs[i]} $op';

    }
   return
     {
       'quiz' : quiz,
       'response':calcString(quiz)
     };
  }
  bool checkResponse(int response, int result){
    if(response == result){
      return true;
    }else{
      return false;
    }
  }
}

