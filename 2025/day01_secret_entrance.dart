import 'dart:convert';
import 'dart:io';

void main() {
  File('input01_large.txt').readAsString().then((String content) {
    var first_answer = 0;
    var second_answer = 0;

    var dial = 50;
    var ls = new LineSplitter();
    var lines = ls.convert(content);

    for (var line in lines) {
      var dir = line[0];
      var turn = int.parse(line.substring(1));

      if (dir == 'R') {
        second_answer += (dial + turn) ~/ 100;
        dial = (dial + turn) % 100;
      } else {
        if (dial == 0) second_answer--;
        second_answer += ((100 - dial) + turn) ~/ 100;
        dial = (dial - turn) % 100;
      }

      if (dial == 0) {
        first_answer++;
      }
    }

    print('first answer: $first_answer');
    print('second answer: $second_answer');
  });
}
