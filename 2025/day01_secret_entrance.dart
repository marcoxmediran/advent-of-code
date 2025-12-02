import 'dart:io';

void main() {
  File('input01_large.txt').readAsString().then((String content) {
    var firstAnswer = 0;
    var secondAnswer = 0;

    var dial = 50;
    var lines = content.trim().split('\n');

    for (var line in lines) {
      var dir = line[0];
      var turn = int.parse(line.substring(1));

      if (dir == 'R') {
        secondAnswer += (dial + turn) ~/ 100;
        dial = (dial + turn) % 100;
      } else {
        if (dial == 0) secondAnswer--;
        secondAnswer += ((100 - dial) + turn) ~/ 100;
        dial = (dial - turn) % 100;
      }

      if (dial == 0) {
        firstAnswer++;
      }
    }

    print('first answer: $firstAnswer');
    print('second answer: $secondAnswer');
  });
}
