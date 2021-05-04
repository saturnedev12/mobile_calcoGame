import 'dart:math';
import 'dart:math';
import 'package:petitparser/petitparser.dart';
void main(){
  Game game = new Game();
  print('${game.getQuiz()} \n');
//for(int i=1;i<20;i++)


}

class Game{
  Random rnd = new Random();
  int sizeListe, idop;
  List nbrs, operators=['+','-','*'];
  String quiz = "",op;
  getQuiz(){
    sizeListe = rnd.nextInt(3) + 2;
    nbrs = List(sizeListe);
    for(int i=0; i< sizeListe; i++){
      nbrs[i] = rnd.nextInt(10);
      idop = rnd.nextInt(operators.length);
      op = operators[idop];
      if(i == sizeListe-1) op = "";
      quiz = quiz + ' ${nbrs[i]} $op';

    }

    return [quiz,calcString(quiz)];
  }

}



Parser buildParser() {
  final builder = ExpressionBuilder();
  builder.group()
    ..primitive((pattern('+-').optional() &
    digit().plus() &
    (char('.') & digit().plus()).optional() &
    (pattern('eE') & pattern('+-').optional() & digit().plus())
        .optional())
        .flatten('number expected')
        .trim()
        .map(num.tryParse))
    ..wrapper(
        char('(').trim(), char(')').trim(), (left, value, right) => value);
  builder.group()..prefix(char('-').trim(), (op, a) => -a);
  builder.group()..right(char('^').trim(), (a, op, b) => pow(a, b));
  builder.group()
    ..left(char('*').trim(), (a, op, b) => a * b)
    ..left(char('/').trim(), (a, op, b) => a / b);
  builder.group()
    ..left(char('+').trim(), (a, op, b) => a + b)
    ..left(char('-').trim(), (a, op, b) => a - b);
  return builder.build().end();
}

calcString(String text) {
  final parser = buildParser();
  final input = text;
  final result = parser.parse(input);
  if (result.isSuccess)
    return result.value;
  else
    return int.parse(text);
}
