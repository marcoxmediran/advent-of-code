import java.io.FileReader;
import java.util.ArrayList;
import java.util.Scanner;

public class day01Trebuchet {
    public static void main(String[] args) throws Exception {
        Scanner scanner = new Scanner(new FileReader("day01Input.txt"));
        ArrayList<String> inputStrings = new ArrayList<>();
        while (scanner.hasNext()) {
            inputStrings.add(scanner.nextLine());
        }

        int sum = 0;
        ArrayList<String> wordNumbers = new ArrayList<>();
        wordNumbers.add("zero");
        wordNumbers.add("one");
        wordNumbers.add("two");
        wordNumbers.add("three");
        wordNumbers.add("four");
        wordNumbers.add("five");
        wordNumbers.add("six");
        wordNumbers.add("seven");
        wordNumbers.add("eight");
        wordNumbers.add("nine");

        for (int i = 0; i < inputStrings.size(); i++) {
            String current = inputStrings.get(i);
            ArrayList<Integer> digits = new ArrayList<>();
            for (int j = 0; j < current.length(); j++) {
                // if alphanumeric
                char currentChar = current.charAt(j);
                if (Character.isDigit(currentChar)) {
                    digits.add((Integer) Character.getNumericValue(currentChar));
                } else {    // bruteforce
                    for (int k = j; k < current.length() + 1; k++) {
                        String subString = current.substring(j, k);
                        if (wordNumbers.contains(subString)) {
                            digits.add(wordNumbers.indexOf(subString));
                            break;
                        }
                    }
                }
            }
            if (!digits.isEmpty()) {
                sum += Integer.valueOf(getCalibration(digits));
            }
        }

        System.out.println("Calibration of whole document: " + sum);
    }

    public static String getCalibration(ArrayList<Integer> digits) {
        return "" + digits.getFirst() + digits.getLast();
    }
}