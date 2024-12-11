import 'dart:collection';
import 'dart:io';

// Global Variable
Map<(int, int), int> cache = HashMap();

void main() {
  File('input11_large.txt').readAsString().then(
    (String content) {
      List<int> pebbles =
          content.replaceAll('\n', '').split(' ').map(int.parse).toList();
      int answer = 0;
      int iteration = 75;

      for (int pebble in pebbles) {
        answer += GetCount(pebble, iteration);
      }

      print('answer: $answer');
    },
  );
}

int GetCount(int pebble, int iteration) {
  int count = 0;
  if (iteration == 0) {
    return 1;
  }
  if (!cache.containsKey((pebble, iteration))) {
    if (pebble == 0) {
      count = GetCount(1, iteration - 1);
    } else if (pebble.toString().length % 2 == 0) {
      String p_string = pebble.toString();
      int half_length = (p_string.length / 2).floor();
      count += GetCount(
          int.parse(p_string.substring(0, half_length)), iteration - 1);
      count +=
          GetCount(int.parse(p_string.substring(half_length)), iteration - 1);
    } else {
      count = GetCount(pebble * 2024, iteration - 1);
    }
    cache[(pebble, iteration)] = count;
  }
  return cache[(pebble, iteration)]!;
}
