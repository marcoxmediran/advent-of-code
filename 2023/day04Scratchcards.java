import java.util.*;
import java.io.*;

public class day04Scratchcards {
	public static void main(String[] args) throws FileNotFoundException {
		Scanner scanner = new Scanner(new FileReader("day04InputSmall.txt"));
		ArrayList<String> inputStrings = new ArrayList<>();
		while (scanner.hasNextLine()) {
			inputStrings.add(scanner.nextLine());
		}

		int answer1 = 0;
		int answer2 = 0;

		// part 1
		for (int line = 0; line < inputStrings.size(); line++) {
			String currentLine = inputStrings.get(line);
			int matchCounter = 0;
			String fixedLine = currentLine.substring(currentLine.indexOf(':') + 2);
			String[] splitLine = fixedLine.split(" \\| ");

			// calculations
			ArrayList<Integer> choices = getNumbers(splitLine[0]);
			ArrayList<Integer> results = getNumbers(splitLine[1]);
			for (Integer number : choices) {
				if (results.contains(number)) {
					matchCounter++;
				}
			}
			answer1 += Math.pow(2, matchCounter - 1);
		}
		System.out.println("Part 1: " + answer1);
		System.out.println("Part 2: " + answer2);
		scanner.close();
	}

	public static ArrayList<Integer> getNumbers(String line) {
		ArrayList<Integer> numbers = new ArrayList<>();
		line = line.trim().replaceAll("\\s+", " ");
		for (String number : line.split(" ")) {
			numbers.add(Integer.valueOf(number));
		}
		return numbers;
	}
}
