import 'dart:io';
import 'dart:math';

void main() async {
  final content = await File('input05_large.txt').readAsString();

  var firstAnswer = 0;
  var secondAnswer = 0;

  var lines = content.trim().split(RegExp(r'\r?\n\r?\n'));

  var rawRanges = lines[0].split('\n');
  var ranges = rawRanges.map((element) {
    var s = element.split('-');
    return [int.parse(s[0]), int.parse(s[1])];
  }).toList();

  var ingredients = lines[1].split('\n').map(int.parse).toList();

  ranges.sort((a, b) => a[0].compareTo(b[0]));

  List<List<int>> mergedRanges = [];
  if (ranges.isNotEmpty) {
    mergedRanges.add(ranges[0]);
    for (int i = 1; i < ranges.length; i++) {
      if (ranges[i][0] <= mergedRanges.last[1]) {
        mergedRanges.last[1] = max(mergedRanges.last[1], ranges[i][1]);
      } else {
        mergedRanges.add(ranges[i]);
      }
    }
  }

  for (var ingredient in ingredients) {
    for (var range in mergedRanges) {
      if (range[0] > ingredient) break;

      if (ingredient >= range[0] && ingredient <= range[1]) {
        firstAnswer++;
        break;
      }
    }
  }

  for (var range in mergedRanges) {
    secondAnswer += (range[1] - range[0] + 1);
  }

  print('first answer: $firstAnswer');
  print('second answer: $secondAnswer');
}
