import 'dart:io';
import 'dart:math';

void main() async {
  final content = await File('input09_large.txt').readAsString();

  int firstAnswer = 0;
  int secondAnswer = 0;

  List<List<int>> tiles = content
      .trim()
      .split('\n')
      .map((line) => line.split(',').map(int.parse).toList())
      .toList();
  List<List<List<int>>> edges = [];
  for (int i = 0; i < tiles.length; i++) {
    var pointA = tiles[i];
    var pointB = tiles[(i + 1) % tiles.length];
    edges.add([pointA, pointB]);
  }

  for (int i = 0; i < tiles.length; i++) {
    for (int j = i + 1; j < tiles.length; j++) {
      int area = getArea(tiles[i], tiles[j]);

      if (area > firstAnswer) {
        firstAnswer = area;
      }

      if (isRectangleValid(tiles[i], tiles[j], edges) && area > secondAnswer) {
        secondAnswer = area;
      }
    }
  }

  print('first answer: $firstAnswer');
  print('second answer: $secondAnswer');
}

int getArea(List<int> pointA, List<int> pointB) {
  int length = (pointA[0] - pointB[0]).abs() + 1;
  int width = (pointA[1] - pointB[1]).abs() + 1;
  return length * width;
}

bool isRectangleValid(
  List<int> pointA,
  List<int> pointB,
  List<List<List<int>>> edges,
) {
  int minX = min(pointA[0], pointB[0]);
  int maxX = max(pointA[0], pointB[0]);
  int minY = min(pointA[1], pointB[1]);
  int maxY = max(pointA[1], pointB[1]);

  for (var edge in edges) {
    var point1 = edge[0];
    var point2 = edge[1];

    // Vertical edge
    if (point1[0] == point2[0]) {
      int x = point1[0];
      int y1 = min(point1[1], point2[1]);
      int y2 = max(point1[1], point2[1]);

      // If vertical line within x range AND intersects y
      if ((x > minX && x < maxX) && (y1 < maxY && y2 > minY)) {
        return false;
      }
    }
    // Horizontal edge
    else {
      int y = point1[1];
      int x1 = min(point1[0], point2[0]);
      int x2 = max(point1[0], point2[0]);

      // If horizontal line within y range AND intersects x
      if ((y > minY && y < maxY) && (x1 < maxX && x2 > minX)) {
        return false;
      }
    }
  }

  return true;
}
