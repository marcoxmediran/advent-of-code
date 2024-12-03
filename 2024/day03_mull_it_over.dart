import 'dart:io';

void main() {
  File('input03_large.txt').readAsString().then(
    (String content) {
      int first_answer = 0;
      int second_answer = 0;

      RegExp master_pattern = RegExp(r'''mul\(\d+,\d+\)|do\(\)|don't\(\)''');
      RegExp do_pattern = RegExp(r'''do\(\)''');
      RegExp dont_pattern = RegExp(r'''don't\(\)''');
      bool is_do = true;

      Iterable<RegExpMatch> matches = master_pattern.allMatches(content);
      for (final match in matches) {
        var instruction = match[0]!;
        if (dont_pattern.hasMatch(instruction)) {
          is_do = false;
        } else if (do_pattern.hasMatch(instruction)) {
          is_do = true;
        } else {
          List<int> numbers = instruction
              .replaceAll(RegExp(r'[mul\(\)]'), '')
              .split(',')
              .map(int.parse)
              .toList();
          first_answer += numbers[0] * numbers[1];
          if (is_do) {
            second_answer += numbers[0] * numbers[1];
          }
        }
      }

      print('first_answer: $first_answer');
      print('second_answer: $second_answer');
    },
  );
}
