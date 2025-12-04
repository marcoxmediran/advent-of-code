import 'dart:io';

void main() async {
  final content = await File('input04_large.txt').readAsString();

  var firstAnswer = 0;
  var secondAnswer = 0;

  var lines = content.trim().split('\n');

  var directions = [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1],
  ];

  var removed = <String>{};
  var count = 0;
  var runs = 0;

  while (true) {
    count = 0;
    for (var i = 0; i < lines.length; i++) {
      var line = lines[i];
      for (var j = 0; j < line.length; j++) {
        if (removed.contains('$i,$j')) {
          continue;
        }
        if (line[j] == '@') {
          var adjacent = 0;
          for (int k = 0; k < directions.length; k++) {
            var dir = directions[k];
            var row = i + dir[0];
            var col = j + dir[1];

            if (row >= 0 &&
                row < lines.length &&
                col >= 0 &&
                col < line.length) {
              var cell = lines[row][col];
              if (cell == '@' && !removed.contains('$row,$col')) adjacent++;
            }
          }

          if (adjacent < 4) {
            if (runs == 1) firstAnswer++;
            secondAnswer++;
            removed.add('$i,$j');
            count++;
          }
        }
      }
    }

    runs++;

    if (count == 0) break;
  }

  print('first answer: $firstAnswer');
  print('second answer: $secondAnswer');
}
