import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Scanner;

public class day06WaitForIt {
    public static void main(String[] args) throws FileNotFoundException {
        Scanner scanner = new Scanner(new FileReader("day06Input.txt"));
        ArrayList<String> inputStrings = new ArrayList<>();
        while (scanner.hasNextLine()) {
            String newLine = scanner.nextLine().trim().replaceAll("\\s+", " ");
            inputStrings.add(newLine);
        }

        // part 1
        int answer1 = 1;
        ArrayList<Integer> duration = getNumbers(inputStrings.get(0), 6);
        ArrayList<Integer> distance = getNumbers(inputStrings.get(1), 10);

        for (int i = 0; i < duration.size(); i++) {
            int t = duration.get(i);
            int d = distance.get(i);
            int validCounter = 0;
            for (int j = 1; j <= t; j++) {
                int speed = j;
                int timeRemaining = t - speed;
                if (speed * timeRemaining > d) {
                    validCounter++;
                }
            }
            answer1 *= validCounter;
        }

        // part 2
        int answer2 = 0;
        long t = combineNumbers(duration);
        long d = combineNumbers(distance);
        for (int j = 0; j < t; j++) {
            long speed = j;
            long timeRemaining = t - speed;
            if (speed * timeRemaining > d) {
                answer2++;
            }
        }

        System.out.println("Part 1: " + answer1);
        System.out.println("Part 2: " + answer2);
        scanner.close();
    }

    public static ArrayList<Integer> getNumbers(String line, int startingIndex) {
        String fixedLine = line.substring(startingIndex);
        ArrayList<Integer> numbers = new ArrayList<>();
        for (String element : fixedLine.split(" ")) {
            numbers.add(Integer.valueOf(element));
        }
        return numbers;
    }

    public static long combineNumbers(ArrayList<Integer> numbers) {
        String number = "";
        for (Integer element : numbers) {
            number += element;
        }
        return Long.valueOf(number);
    }
    
}
