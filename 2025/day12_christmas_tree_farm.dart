import 'dart:io';

void main() async {
  final content = await File('input12_large.txt').readAsString();

  int firstAnswer = 0;

  var lines = content.trim().split('\n\n');

  //var shapes = lines.map((line) {
  //  return line
  //      .split('\n')
  //      .join()
  //      .replaceAll(RegExp(r'[^#]'), '')
  //      .length
  //      .toInt();
  //}).toList();
  var shapes = List.generate(lines.length - 1, (_) => 9);

  var regions = lines.last.split('\n');
  for (var region in regions) {
    List<int> dimensions = region
        .substring(0, region.indexOf(':'))
        .split('x')
        .map(int.parse)
        .toList();
    int area = dimensions.reduce((a, b) => a * b);

    List<int> requirements = region
        .substring(region.indexOf(':') + 2)
        .trim()
        .split(' ')
        .map(int.parse)
        .toList();
    
    int fit = 0;
    for (int i = 0; i < requirements.length; i++) {
      fit += shapes[i] * requirements[i];
    }

    if (fit <= area) firstAnswer++;

  }

  print('first answer: $firstAnswer');
}
