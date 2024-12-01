import 'dart:convert';
import 'dart:io';

void main() {
  File('input01_large.txt').readAsString().then((String content) {
    var first_answer = 0;
    var second_answer = 0;

    var ls = new LineSplitter();
    var lines = ls.convert(content);
    List<int> left = [];
    List<int> right = [];
    Map<int, int> counter = new Map();
    for (var line in lines) {
      var numbers = line.split('   ');
      var l = int.parse(numbers[0]);
      var r = int.parse(numbers[1]);
      left.add(l);
      right.add(r);
      if (counter.containsKey(r)) {
        counter[r] = (counter[r]! + 1);
      } else {
        counter[r] = 1;
      }
    }
    left.sort();
    right.sort();

    for (int i = 0; i < left.length; i++) {
      first_answer += (right[i] - left[i]).abs();
      if (counter.containsKey(left[i])) {
        second_answer += left[i] * counter[left[i]]!;
      }
    }

    print('first answer: $first_answer');
    print('second answer: $second_answer');
  });
}
