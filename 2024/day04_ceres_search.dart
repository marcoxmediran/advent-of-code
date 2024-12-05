import 'dart:convert';
import 'dart:io';

void main() {
  File('input04_large.txt').readAsString().then(
    (String content) {
      int first_answer = 0;
      int second_answer = 0;

      LineSplitter ls = LineSplitter();
      List<String> lines = ls.convert(content);
      final int pad_length = lines.first.length + 3;
      final String row_padding = '_' * (pad_length + 3);
      for (int i = 0; i < lines.length; i++) {
        lines[i] =
            lines[i].padLeft(pad_length, '_').padRight(pad_length + 3, '_');
      }
      for (int i = 0; i < 3; i++) {
        lines.insert(0, row_padding);
        lines.insert(lines.length, row_padding);
      }

      first_answer += count_horizontal(lines);
      first_answer += count_vertical(lines);
      first_answer += count_diagonal(lines);
      second_answer += count_mas(lines);

      print('first_answer: $first_answer');
      print('second_answer: $second_answer');
    },
  );
}

int count_horizontal(List<String> lines) {
  int answer = 0;
  for (int row = 0; row < lines.length; row++) {
    String line = lines[row];
    for (int col = 0; col < line.length; col++) {
      String character = line[col];
      if (character == 'X') {
        if (line[col + 1] == 'M' &&
            line[col + 2] == 'A' &&
            line[col + 3] == 'S') {
          answer++;
        }
        if (line[col - 1] == 'M' &&
            line[col - 2] == 'A' &&
            line[col - 3] == 'S') {
          answer++;
        }
      }
    }
  }
  return answer;
}

int count_vertical(List<String> lines) {
  int answer = 0;
  for (int row = 0; row < lines.length; row++) {
    String line = lines[row];
    for (int col = 0; col < line.length; col++) {
      String character = line[col];
      if (character == 'X') {
        if (lines[row + 1][col] == 'M' &&
            lines[row + 2][col] == 'A' &&
            lines[row + 3][col] == 'S') {
          answer++;
        }
        if (lines[row - 1][col] == 'M' &&
            lines[row - 2][col] == 'A' &&
            lines[row - 3][col] == 'S') {
          answer++;
        }
      }
    }
  }
  return answer;
}

int count_diagonal(List<String> lines) {
  int answer = 0;
  for (int row = 0; row < lines.length; row++) {
    String line = lines[row];
    for (int col = 0; col < line.length; col++) {
      String character = line[col];
      if (character == 'X') {
        if (lines[row - 1][col - 1] == 'M' &&
            lines[row - 2][col - 2] == 'A' &&
            lines[row - 3][col - 3] == 'S') {
          answer++;
        }
        if (lines[row - 1][col + 1] == 'M' &&
            lines[row - 2][col + 2] == 'A' &&
            lines[row - 3][col + 3] == 'S') {
          answer++;
        }
        if (lines[row + 1][col - 1] == 'M' &&
            lines[row + 2][col - 2] == 'A' &&
            lines[row + 3][col - 3] == 'S') {
          answer++;
        }
        if (lines[row + 1][col + 1] == 'M' &&
            lines[row + 2][col + 2] == 'A' &&
            lines[row + 3][col + 3] == 'S') {
          answer++;
        }
      }
    }
  }
  return answer;
}

int count_mas(List<String> lines) {
  int answer = 0;
  for (int row = 0; row < lines.length; row++) {
    String line = lines[row];
    for (int col = 0; col < line.length; col++) {
      String character = line[col];
      if (character == 'A') {
        String upper_left = lines[row - 1][col - 1];
        String upper_right = lines[row - 1][col + 1];
        String lower_left = lines[row + 1][col - 1];
        String lower_right = lines[row + 1][col + 1];
        if (((upper_left == 'M' && lower_right == 'S') ||
                (upper_left == 'S' && lower_right == 'M')) &&
            ((upper_right == 'M' && lower_left == 'S') ||
                (upper_right == 'S' && lower_left == 'M'))) {
          answer++;
        }
      }
    }
  }
  return answer;
}
