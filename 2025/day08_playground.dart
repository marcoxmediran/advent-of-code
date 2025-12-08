// DSU! (https://en.wikipedia.org/wiki/Disjoint-set_data_structure)

import 'dart:io';
import 'dart:math';

void main() async {
  final content = await File('input08_large.txt').readAsString();

  var firstAnswer = 0;
  var secondAnswer = 0;

  var lines = content
      .trim()
      .split('\n')
      .map(
        (line) => line.split(',').map((element) => int.parse(element)).toList(),
      )
      .toList();

  var dsu = UnionFind(lines.length);

  List<Edge> edges = [];
  for (int u = 0; u < lines.length; u++) {
    for (int v = u + 1; v < lines.length; v++) {
      double distance = getDistance(lines[u], lines[v]);
      edges.add(Edge(u, v, distance));
    }
  }
  edges.sort((a, b) => a.distance.compareTo(b.distance));

  var maxConnections = 10;
  for (int i = 0; i < maxConnections; i++) {
    Edge edge = edges[i];
    dsu.union(edge.u, edge.v);
  }

  var rawSets = <int, int>{};
  for (int i = 0; i < lines.length; i++) {
    var root = dsu.find(i);
    rawSets[root] = (rawSets[root] ?? 0) + 1;
  }

  var sizes = rawSets.values.toList();
  sizes.sort((a, b) => b.compareTo(a));

  firstAnswer = sizes[0] * sizes[1] * sizes[2];

  // Reset DSU
  var distinctGroups = lines.length;
  dsu = UnionFind(lines.length);
  for (var edge in edges) {
    var isMerged = dsu.union(edge.u, edge.v);

    if (isMerged) {
      distinctGroups--;
      if (distinctGroups == 1) {
        var boxA = lines[edge.u];
        var boxB = lines[edge.v];

        print('(${edge.u},${edge.v}): $boxA, $boxB');

        secondAnswer = boxA[0] * boxB[0];
        break;
      }
    }
  }

  print('first answer: $firstAnswer');
  print('second answer: $secondAnswer');
}

double getDistance(List<int> a, List<int> b) {
  return sqrt(
    pow((a[0] - b[0]), 2) + pow((a[1] - b[1]), 2) + pow((a[2] - b[2]), 2),
  );
}

class Edge {
  final int u;
  final int v;
  final double distance;

  Edge(this.u, this.v, this.distance);
}

class UnionFind {
  late List<int> parent;

  UnionFind(int n) {
    parent = List<int>.generate(n, (index) => index);
  }

  int find(int u) {
    if (parent[u] != u) {
      parent[u] = find(parent[u]);
    }
    return parent[u];
  }

  bool union(int u, int v) {
    int rootU = find(u);
    int rootV = find(v);

    if (rootU != rootV) {
      parent[rootU] = rootV;
      return true;
    } 

    return false;
  }
}
