import 'dart:collection';
import 'dart:io';
import 'dart:math';

void main() async {
  final content = await File('input10_large.txt').readAsString();

  int firstAnswer = 0;
  int secondAnswer = 0;

  var lines = content
      .trim()
      .split('\n')
      .map((line) => line.replaceAll(RegExp(r'[\[\]\(\)\{\}]'), ''))
      .toList()
      .map((line) => line.replaceAll(RegExp(r'#'), '1'))
      .toList()
      .map((line) => line.replaceAll('\.', '0'))
      .toList()
      .map((line) => line.split(' '))
      .toList();
  for (var line in lines) {
    int target = getTarget(line.removeAt(0));
    String joltage = line.removeLast();
    List<int> buttons = parseButtons(line);
    int minimumSteps = solve(target, buttons);

    firstAnswer += minimumSteps;

    // print('Target: $target, Joltage: $joltage, Buttons: $buttons');
    // print('Minimum Steps: $minimumSteps\n');
  }

  print('first answer: $firstAnswer');
  print('second answer: $secondAnswer');
}

int solve(int target, List<int> buttons) {
  Queue<List<int>> queue = Queue();
  Set<int> visited = {};

  queue.add([0, 0]);
  visited.add(0);

  while (queue.isNotEmpty) {
    var state = queue.removeFirst();
    int value = state[0];
    int steps = state[1];

    if (value == target) return steps;

    for (int button in buttons) {
      int nextState = value ^ button;

      if (!visited.contains(nextState)) {
        visited.add(nextState);
        queue.add([nextState, steps + 1]);
      }
    }
  }

  return -1;
}

int getTarget(String s) {
  return int.parse(s.split('').reversed.join(), radix: 2);
}

List<int> parseButtons(List<String> buttons) {
  return buttons.map((element) {
    final indices = element.split(',').map(int.parse);

    int bitmap = 0;

    for (var index in indices) {
      bitmap += (pow(10, index)).toInt();
    }

    return int.parse(bitmap.toString(), radix: 2);
  }).toList();
}
