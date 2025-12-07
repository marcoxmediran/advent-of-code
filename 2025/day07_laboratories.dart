import 'dart:collection';
import 'dart:io';

var cache = <(int, int), int>{};
var rowCount = 0;
var lines = [];

void main() async {
  final content = await File('input07_large.txt').readAsString();

  var firstAnswer = 0;
  var secondAnswer = 0;

  lines = content.trim().split('\n');
  rowCount = lines.length;
  var start = (0, lines[0].indexOf('S'));

  var queue = Queue<(int, int)>.from([start]);
  var seen = <(int, int)>{};

  // First Part (BFS)
  while (queue.isNotEmpty) {
    var coordinate = queue.removeFirst();

    if (seen.contains(coordinate)) continue;

    seen.add(coordinate);

    if (coordinate.$1 + 1 == rowCount) continue;

    if (lines[coordinate.$1 + 1][coordinate.$2] == '^') {
      queue.add((coordinate.$1 + 1, coordinate.$2 + 1));
      queue.add((coordinate.$1 + 1, coordinate.$2 - 1));
      firstAnswer++;
    } else {
      queue.add((coordinate.$1 + 1, coordinate.$2));
    }
  }

  // Second Part (DFS)
  secondAnswer = countPaths(start.$1, start.$2);

  print('first answer: $firstAnswer');
  print('second answer: $secondAnswer');
}

int countPaths(int r, int c) {
  if (r + 1 == rowCount) return 1;

  if (cache.containsKey((r, c))) return cache[(r, c)]!;

  int result = 0;
  var charBelow = lines[r + 1][c];

  if (charBelow == '^') {
    result = countPaths(r + 1, c - 1) + countPaths(r + 1, c + 1);
  } else {
    result = countPaths(r + 1, c);
  }

  cache[(r, c)] = result;

  return result;
}
