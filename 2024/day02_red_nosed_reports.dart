import 'dart:convert';
import 'dart:io';

void main() {
  File('input02_large.txt').readAsString().then(
    (String content) {
      int first_answer = 0;
      int second_answer = 0;

      var ls = new LineSplitter();
      var lines = ls.convert(content);
      for (var line in lines) {
        var numbers = line.split(' ').map(int.parse).toList();
        var error_count = 0;
        var is_tolerated = false;
        if (!checkIfSafe(numbers)) {
          error_count += 1;
          for (int i = 0; i < numbers.length; i++) {
            List<int> sublist = [...numbers];
            sublist.removeAt(i);
            if (checkIfSafe(sublist)) {
              is_tolerated = true;
            }
          }
        }
        first_answer += error_count == 0 ? 1 : 0;
        second_answer += is_tolerated || error_count == 0 ? 1 : 0;
      }

      print('first_answer: $first_answer');
      print('second_answer: $second_answer');
    },
  );
}

bool checkIfSafe(List<int> numbers) {
  bool is_increasing = numbers[0] < numbers[1] ? true : false;
  for (int i = 0; i < numbers.length - 1; i++) {
    int current = numbers[i];
    int next = numbers[i + 1];
    int difference = (current - next).abs();
    if (difference > 3 || difference < 1) {
      return false;
    } else if (is_increasing && current > next) {
      return false;
    } else if (!is_increasing && current < next) {
      return false;
    }
  }
  return true;
}
