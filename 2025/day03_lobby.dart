import 'dart:io';

void main() async {
  final content = await File('input03_large.txt').readAsString();

  var firstAnswer = 0;
  var secondAnswer = 0;

  var lines = content.trim().split('\n');

  firstAnswer = lobby(lines, 2);
  secondAnswer = lobby(lines, 12);

  print('first answer: $firstAnswer');
  print('second answer: $secondAnswer');
}

int lobby(List<String> lines, int targetLength) {
  var ans = 0;

  for (var line in lines) {
    var strAns = '';
    var pos = 0;

    // Iterate over digits remaining
    for (int i = targetLength - 1; i >= 0; i--) {
      var highest = 0;
      var highestPos = 0;

      // Find the highest digit
      for (int j = pos; j < line.length - i; j++) {
        var current = int.parse(line[j]);

        // Save time if current is the highest possible digit
        if (current == 9) {
          highest = current;
          highestPos = j;
          break;
        }

        // Find highest digit
        if (current > highest) {
          highest = current;
          highestPos = j;
        }
      }

      // Move the starting index after the highest digit
      pos = highestPos + 1;
      strAns += highest.toString();
    }
    ans += int.parse(strAns);
  }
  return ans;
}
