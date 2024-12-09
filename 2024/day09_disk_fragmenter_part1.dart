import 'dart:io';

void main() {
  File('input09_large.txt').readAsString().then(
    (String content) {
      List<String> blocks = ConvertToBlocks(content);
      ArrangeBlocks(blocks);
      print('first_answer: ${GetAnswer(blocks)}');
    },
  );
}

void PrintBlocks(List<String> blocks) {
  for (int i = 0; i < blocks.length; i++) {
    stdout.write(blocks[i]);
  }
  stdout.write('\n');
}

List<String> ConvertToBlocks(String content) {
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
  return blocks;
}

void ArrangeBlocks(List<String> blocks) {
  int start_index = blocks.indexOf('.');
  for (int i = blocks.length; i > start_index; i--) {
    int first_free_index = blocks.indexOf('.');
    int last_file_index = blocks.lastIndexWhere((String element) => element != '.');
    if (first_free_index > last_file_index) {
      return;
    }
    blocks[first_free_index] = blocks[last_file_index];
    blocks[last_file_index] = '.';
  }
  return;
}

int GetAnswer(List<String> blocks) {
  int answer = 0;
  for (int i = 0; blocks[i] != '.'; i++) {
    answer += int.parse(blocks[i]) * i;
  }
  return answer;
}
