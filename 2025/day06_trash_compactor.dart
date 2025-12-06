import 'dart:io';

void main() async {
  final content = await File('input06_large.txt').readAsString();

  var firstAnswer = 0;
  var secondAnswer = 0;

  var lines = content
      .trim()
      .split('\n')
      .map((line) => line.trim().split(RegExp(r'[ ]+')))
      .toList();

  // First Part
  final len = lines.length;
  for (int i = 0; i < lines[0].length; i++) {
    var toMultiply = lines[len - 1][i] == '*';
    var start = int.parse(lines[0][i]);
    for (int j = 1; j < len - 1; j++) {
      var current = int.parse(lines[j][i]);
      if (toMultiply) {
        start *= current;
      } else {
        start += current;
      }
    }
    firstAnswer += start;
  }

  // Second Part
  var cephalopods = content.split('\n');
  var toMultiply = true;
  var nums = <int>[];
  for (int i = 0; i < cephalopods[0].length; i++) {
    var buffer = '';
    for (int j = 0; j < cephalopods.length - 1; j++) {
      var current = cephalopods[j][i];
      if (current != '*' && current != '+' && current.isNotEmpty)
        buffer += current;
      else
        toMultiply = current == '*';
    }
    buffer = buffer.trim();
    if (buffer.isEmpty) {
      if (toMultiply) {
        secondAnswer += nums.reduce((a, b) => a * b);
      } else {
        secondAnswer += nums.reduce((a, b) => a + b);
      }
      nums.clear();
    } else {
      nums.add(int.parse(buffer));
    }
  }
  if (toMultiply) {
    secondAnswer += nums.reduce((a, b) => a * b);
  } else {
    secondAnswer += nums.reduce((a, b) => a + b);
  }

  print('first answer: $firstAnswer');
  print('second answer: $secondAnswer');
}
