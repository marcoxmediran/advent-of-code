import 'dart:convert';
import 'dart:io';

class position {
  int y;
  int x;
  position(this.y, this.x);
}

void main() {
  File('input06_small.txt').readAsString().then(
    (String content) {
      int first_answer = 0;

      LineSplitter ls = LineSplitter();
      List<String> lines = ls.convert(content);
      List<List<int>> matrix = generate_matrix(lines);
      int dimension = matrix.length;

      var c = get_guard_coord(matrix);
      position coord = position(c.$1, c.$2);
      print('coord: (${coord.y}, ${coord.x})');

      while (is_in(coord, dimension)) {
        if (matrix[coord.y - 1][coord.x] == 1) {
          matrix[coord.y][coord.x] = 2;
          matrix = rotate90(matrix);
          int previous_y = coord.y;
          coord.y = dimension - coord.x - 1;
          coord.x = previous_y;
        } else {
          coord.y -= 1;
          matrix[coord.y][coord.x] = 2;
        }
      }

      first_answer = count_twos(matrix);
      print('\nfirst_answer: $first_answer');
    },
  );
}

int count_twos(List<List<int>> matrix) {
  int dimension = matrix.length;
  int count = 0;
  for (int row = 0; row < dimension; row++) {
    for (int col = 0; col < dimension; col++) {
      if (matrix[row][col] == 2) {
        count++;
      }
    }
  }
  return count;
}

bool is_in(position coord, int dimension) {
  return coord.y > 0 &&
      coord.y < dimension &&
      coord.x > 0 &&
      coord.x < dimension;
}

void print_matrix(List<List<int>> matrix) {
  for (var row in matrix) {
    print(row);
  }
}

List<List<int>> generate_matrix(List<String> lines) {
  int dimension = lines.first.length;
  List<List<int>> matrix =
      List.generate(dimension, (_) => List.filled(dimension, 0));
  for (int row = 0; row < dimension; row++) {
    for (int col = 0; col < dimension; col++) {
      String character = lines[row][col];
      if (character == '#') {
        matrix[row][col] = 1;
      } else if (character == '^') {
        matrix[row][col] = 2;
      }
    }
  }
  return matrix;
}

List<List<int>> rotate90(List<List<int>> matrix) {
  int dimension = matrix.length;
  List<List<int>> rotated_matrix =
      List.generate(dimension, (_) => List.filled(dimension, 0));
  for (int row = 0; row < dimension; row++) {
    for (int col = 0; col < dimension; col++) {
      rotated_matrix[dimension - col - 1][row] = matrix[row][col];
    }
  }
  return rotated_matrix;
}

(int, int) get_guard_coord(List<List<int>> matrix) {
  int dimension = matrix.length;
  for (int row = 0; row < dimension; row++) {
    for (int col = 0; col < dimension; col++) {
      if (matrix[row][col] == 2) {
        return (row, col);
      }
    }
  }
  return (0, 0);
}
