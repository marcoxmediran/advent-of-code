import 'dart:io';

void main() async {
  final content = await File('input05_large.txt').readAsString();

  var firstAnswer = 0;
  var secondAnswer = 0;

  var lines = content.trim().split('\n');

  var ranges = [...lines];
  ranges.removeRange(ranges.indexOf(''), ranges.length);

  var ingredients = [...lines];
  ingredients.removeRange(0, ingredients.indexOf('') + 1);

  for (var ingredient in ingredients) {
    var a = int.parse(ingredient);
    for (var range in ranges) {
      var s = range.split('-');
      var x = int.parse(s[0]);
      var y = int.parse(s[1]);
      if (a >= x && a <= y) {
        firstAnswer++;
        break;
      }
    }
  }

  var fresh = ranges.map((element) => element.split('-')).toList().map((list) {
    return list.map((String value) => int.parse(value)).toList();
  }).toList();
  fresh.sort((a, b) => a[0].compareTo(b[0]));

  var isDec = true;
  while (true) {
    isDec = true;
    for (int i = 0; i < fresh.length - 1; i++) {
      if (fresh[i][1] >= fresh[i + 1][0]) {
        if (fresh[i][1] < fresh[i + 1][1]) fresh[i][1] = fresh[i + 1][1];
        isDec = false;
        fresh.removeAt(i + 1);
      }
    }

    if (isDec) break;
  }

  for (int i = 0; i < fresh.length; i++) {
    secondAnswer += (fresh[i][1] - fresh[i][0] + 1);
  }

  print('first answer: $firstAnswer');
  print('second answer: $secondAnswer');
}
