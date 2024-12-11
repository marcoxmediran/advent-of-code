import 'dart:collection';
import 'dart:io';

void main() {
  File('input11_small.txt').readAsString().then(
    (String content) {
      List<int> pebbles =
          content.replaceAll('\n', '').split(' ').map(int.parse).toList();
      Map<int, (int, int)> even_cache = HashMap();
      Map<int, int> odd_cache = HashMap();
      odd_cache.addAll({1: 2024});

      int iterations = 25;
      for (int i = 0; i < iterations; i++) {
        blink(pebbles, odd_cache, even_cache);
      }

      print('first_answer: ${pebbles.length}');
    },
  );
}

void blink(List<int> pebbles, Map<int, int> odd_cache,
    Map<int, (int, int)> even_cache) {
  int list_length = pebbles.length;
  for (int i = 0; i < list_length; i++) {
    int current_pebble = pebbles[i];
    String string_pebble = current_pebble.toString();
    if (current_pebble == 0) {
      pebbles[i] = 1;
    } else if (string_pebble.length % 2 == 0) {
      if (even_cache.containsKey(current_pebble)) {
        var c = even_cache[current_pebble]!;
        int left = c.$1;
        int right = c.$2;
        pebbles[i] = left;
        pebbles.insert(i + 1, right);
        i += 1;
        list_length += 1;
      } else {
        int half_length = (string_pebble.length / 2).floor();
        int left = int.parse(string_pebble.substring(0, half_length));
        int right = int.parse(string_pebble.substring(half_length));
        pebbles[i] = left;
        pebbles.insert(i + 1, right);
        i += 1;
        list_length += 1;

        even_cache[current_pebble] = (left, right);
      }
    } else {
      if (odd_cache.containsKey(current_pebble)) {
        pebbles[i] = odd_cache[current_pebble]!;
      } else {
        odd_cache[current_pebble] = current_pebble * 2024;
        pebbles[i] = odd_cache[current_pebble]!;
      }
    }
  }
  return;
}
