import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, bool isTrue){
  Widget message;
  if(isTrue){
    message = Text('bonne reponse');
  }else{
    message = Text('mauvaise reponse');
  }
  Widget okButton = FlatButton(
      onPressed: (){
        Navigator.pop(context);
      },
      child: Text('ok')
  );
  AlertDialog alert = AlertDialog(
    title: Text('reponse'),
    content: message,
    actions: [
      okButton,
    ],
  );
  showDialog(context: context, builder: (BuildContext context){
    return alert;
  });
}