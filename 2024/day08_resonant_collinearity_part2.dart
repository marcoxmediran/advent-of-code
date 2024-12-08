import 'dart:collection';
import 'dart:convert';
import 'dart:io';

void main() {
  File('input08_large.txt').readAsString().then(
    (String content) {
      LineSplitter ls = LineSplitter();
      List<String> lines = ls.convert(content);
      var dimensions = GetDimensions(lines);

      Map<String, List<(int, int)>> antennas = GetAntennaCoordinates(lines);
      List<(int, int)> antinodes = [];

      antennas.forEach((key, value) {
        for (int i = 0; i < value.length - 1; i++) {
          var coordinate = value[i];
          for (int j = i + 1; j < value.length; j++) {
            var next_coordinate = value[j];
            var difference = (
              coordinate.$1 - next_coordinate.$1,
              coordinate.$2 - next_coordinate.$2
            );
            var first_coordinate = coordinate;
            while (true) {
              if (IsValidCoordinates(first_coordinate, dimensions)) {
                if (!antinodes.contains(first_coordinate)) {
                  antinodes.add(first_coordinate);
                }
                first_coordinate = (
                  first_coordinate.$1 + difference.$1,
                  first_coordinate.$2 + difference.$2
                );
              } else {
                break;
              }
            }
            var second_coordinate = next_coordinate;
            while (true) {
              if (IsValidCoordinates(second_coordinate, dimensions)) {
                if (!antinodes.contains(second_coordinate)) {
                  antinodes.add(second_coordinate);
                }
                second_coordinate = (
                  second_coordinate.$1 - difference.$1,
                  second_coordinate.$2 - difference.$2
                );
              } else {
                break;
              }
            }
          }
        }
      });
      print('second_answer: ${antinodes.length}');
    },
  );
}

Map<String, List<(int, int)>> GetAntennaCoordinates(List<String> lines) {
  Map<String, List<(int, int)>> antennas = HashMap();
  RegExp matcher = RegExp(r'''^[a-zA-Z0-9 ]''');

  for (int row = 0; row < lines.length; row++) {
    String line = lines[row];
    for (int col = 0; col < line.length; col++) {
      String character = line[col];
      if (matcher.hasMatch(character)) {
        if (!antennas.containsKey(character)) {
          antennas[character] = [];
          antennas[character]!.add((row, col));
        } else {
          antennas[character]!.add((row, col));
        }
      }
    }
  }
  return antennas;
}

bool IsValidCoordinates((int, int) coordinate, int dimensions) {
  return (!(coordinate.$1 > dimensions - 1 ||
      coordinate.$1 < 0 ||
      coordinate.$2 > dimensions - 1 ||
      coordinate.$2 < 0));
}

int GetDimensions(List<String> lines) {
  return lines.length;
}
