/*
 * Note: remove 2 from possible elements in the GeneratePermutations() function
 * to get answer for part 1
*/

import 'dart:convert';
import 'dart:io';

void main() {
  File('input07_large.txt').readAsString().then(
    (String content) {
      int answer = 0;

      LineSplitter ls = LineSplitter();
      List<String> lines = ls.convert(content);
      for (String line in lines) {
        List<String> line_split = line.split(':');
        int result = int.parse(line_split[0]);
        List<int> terms =
            line_split[1].trim().split(' ').map(int.parse).toList();
        List<List<int>> operations = GeneratePermutations(terms.length - 1);
        for (var permutation in operations) {
          int check_result = terms[0];
          for (int i = 0; i < permutation.length; i++) {
            int next_term = terms[i + 1];
            if (permutation[i] == 1) {
              check_result *= next_term;
            } else if (permutation[i] == 0) {
              check_result += next_term;
            } else {
              check_result = int.parse(check_result.toString() + next_term.toString());
            }
          }
          if (check_result == result) {
            answer += result;
            break;
          }
        }
      }

      print('answer: $answer');
    },
  );
}

List<List<int>> GeneratePermutations(int size) {
  List<List<int>> results = [];
  void _recursion(List<int> current, int depth) {
    if (depth == size) {
      results.add(List.from(current));
      return;
    }
    for (int number in [0, 1, 2]) {
      current.add(number);
      _recursion(current, depth + 1);
      current.removeLast();
    }
  }

  _recursion([], 0);
  return results;
}
