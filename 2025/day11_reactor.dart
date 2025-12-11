import 'dart:io';

Map<String, List<String>> graph = {};
Map<String, int> cache = {};

const int NONE = 0;
const int DAC = 1;
const int FFT = 2;
const int BOTH = 3;

void main() async {
  final content = await File('input11_large.txt').readAsString();

  int firstAnswer = 0;
  int secondAnswer = 0;

  var lines = content.trim().split('\n');
  for (var line in lines) {
    String node = line.substring(0, 3);
    List<String> neighbors = line.substring(5).split(' ');
    graph[node] = neighbors;
  }

  firstAnswer = p1('you');
  secondAnswer = p2('svr', NONE);

  print('first answer: $firstAnswer');
  print('second answer: $secondAnswer');
}

int p1(String current) {
  if (current == 'out') return 1;

  if (cache.containsKey(current)) return cache[current]!;

  if (!graph.containsKey(current)) return 0;

  int totalPaths = 0;
  for (String neighbor in graph[current]!) {
    totalPaths += p1(neighbor);
  }

  cache[current] = totalPaths;

  return totalPaths;
}

int p2(String current, int mask) {
  if (current == 'dac') mask |= DAC;
  if (current == 'fft') mask |= FFT;

  if (current == 'out') return (mask == BOTH) ? 1 : 0;

  if (!graph.containsKey(current)) return 0;

  String key = '$current|$mask';
  if (cache.containsKey(key)) return cache[key]!;

  int totalPaths = 0;
  for (String neighbor in graph[current]!) {
    totalPaths += p2(neighbor, mask);
  }

  cache[key] = totalPaths;

  return totalPaths;
}
