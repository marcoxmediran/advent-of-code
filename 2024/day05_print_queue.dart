import 'dart:convert';
import 'dart:io';

void main() {
  File('input05_large.txt').readAsString().then(
    (String content) {
      int first_answer = 0;
      int second_answer = 0;

      LineSplitter ls = LineSplitter();
      List<String> lines = ls.convert(content);
      List<(String, String)> page_orders = [];
      List<List<String>> updates = [];
      List<List<String>> correct_updates = [];
      List<List<String>> incorrect_updates = [];

      RegExp order_matcher = RegExp(r'''\d{2}\|\d{2}''');
      for (int i = 0; i < lines.length; i++) {
        String line = lines[i];
        if (line.isEmpty) {
          continue;
        } else if (order_matcher.hasMatch(line)) {
          page_orders.add((line.split('|')[0], line.split('|')[1]));
        } else {
          updates.add(line.split(','));
        }
      }

      for (var update in updates) {
        bool is_valid = true;
        for (int current = 0; current < update.length; current++) {
          for (int next = current + 1; next < update.length; next++) {
            if (!page_orders.contains((update[current], update[next]))) {
              is_valid = false;
              String temp = update[current];
              update[current] = update[next];
              update[next] = temp;
              continue;
            }
          }
        }
        if (is_valid) {
          correct_updates.add(update);
        } else {
          incorrect_updates.add(update);
        }
      }

      for (var update in correct_updates) {
        first_answer += int.parse(update[(update.length / 2).floor()]);
      }

      for (var update in incorrect_updates) {
        second_answer += int.parse(update[(update.length / 2).floor()]);
      }

      print('first_answer: $first_answer');
      print('second_answer: $second_answer');
    },
  );
}
