import 'dart:io';

void main() {
  File('input02_large.txt').readAsString().then((String content) {
    var firstAnswer = 0;
    var secondAnswer = 0;

    var ranges = content.trim().split(',');

    for (var range in ranges) {
      var intRange = range.trim().split('-');

      var start = int.parse(intRange[0]);
      var end = int.parse(intRange[1]);

      for (int i = start; i <= end; i++) {
        var s = i.toString();

        var left = s.substring(0, s.length ~/ 2);
        var right = s.substring(s.length ~/ 2);

        if (left == right) {
          firstAnswer += int.parse(s);
        }

        for (int j = 1; j <= left.length; j++) {
          if (s.replaceAll(s.substring(0, j), '').isEmpty) {
            secondAnswer += int.parse(s);
            break;
          }
        }
      }
    }

    print('first answer: $firstAnswer');
    print('second answer: $secondAnswer');
  });
}
