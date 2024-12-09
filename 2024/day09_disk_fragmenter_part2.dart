import 'dart:io';

void main() {
  File('input09_large.txt').readAsString().then(
    (String content) {
      var conversion = ConvertToBlocks(content);
      List<String> blocks = conversion.$1;
      int latest_id = conversion.$2;
      ArrangeBlocks(blocks, latest_id);
      print('second_answer: ${GetAnswer(blocks)}');
    },
  );
}

void PrintBlocks(List<String> blocks) {
  for (int i = 0; i < blocks.length; i++) {
    stdout.write(blocks[i]);
  }
  stdout.write('\n');
}

(List<String>, int) ConvertToBlocks(String content) {
  List<String> blocks = [];
  int magnitude;
  int latest_id = 0;
  for (int i = 0; i < content.length - 1; i++) {
    magnitude = int.parse(content[i]);
    if (i % 2 == 0) {
      for (int j = 0; j < magnitude; j++) {
        blocks.add(latest_id.toString());
      }
      latest_id++;
    } else {
      for (int j = 0; j < magnitude; j++) {
        blocks.add('.');
      }
    }
  }
  return (blocks, latest_id - 1);
}

void ArrangeBlocks(List<String> blocks, int latest_id) {
  while (latest_id > 0) {
    var id = GetIdRange(blocks, latest_id);
    List<({int start, int end, int length})> free_spaces = GetFreeList(blocks);

    for (int i = 0; i < free_spaces.length; i++) {
      var space = free_spaces[i];
      if (space.length >= id.length && id.start > space.start) {
        for (int i = 0; i < id.length; i++) {
          blocks[space.start + i] = blocks[id.start + i];
          blocks[id.start + i] = '.';
        }
        break;
      }
    }

    latest_id--;
  }
  return;
}

({int start, int end, int length}) GetIdRange(
    List<String> blocks, int latest_id) {
  int start = blocks.indexOf(latest_id.toString());
  int end = blocks.lastIndexOf(latest_id.toString());
  return (start: start, end: end, length: end - start + 1);
}

List<({int start, int end, int length})> GetFreeList(List<String> blocks) {
  List<({int start, int end, int length})> free_list = [];
  int? start_index;

  for (int i = 0; i < blocks.length; i++) {
    if (blocks[i] == '.') {
      start_index ??= i;
    } else if (start_index != null) {
      free_list.add((start: start_index, end: i - 1, length: i - start_index));
      start_index = null;
    }
  }

  if (start_index != null) {
    free_list.add((
      start: start_index,
      end: blocks.length - 1,
      length: blocks.length - start_index
    ));
  }

  return free_list;
}

int GetAnswer(List<String> blocks) {
  int answer = 0;
  for (int i = 0; i < blocks.length; i++) {
    if (blocks[i] == '.') {
      continue;
    }
    answer += int.parse(blocks[i]) * i;
  }
  return answer;
}
