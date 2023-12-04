import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Scanner;

public class day03GearRatios {
    public static void main(String[] args) throws FileNotFoundException {
        Scanner scanner = new Scanner(new FileReader("day03Input.txt"));
        int size = 140;
        char[][] array2D = new char[size][size];
        for (int row = 0; row < size; row++) {
            char[] line = scanner.nextLine().toCharArray();
            for (int col = 0; col < size; col++) {
                array2D[row][col] = line[col];
            }
        }

        int answer = 0;
        char[][] paddedArray = padArray(array2D, 1);
        // per line
        for (int row = 0; row < paddedArray.length; row++) {
            String currentNumber = "";
            int validCounter = 0;
            for (int col = 0; col < paddedArray[0].length; col++) {
                char currentChar = paddedArray[row][col];
                if (Character.isDigit(currentChar)) {
                    currentNumber += currentChar;
                    for (int i = row - 1; i <= row + 1; i++) {
                        for (int j = col - 1; j <= col + 1; j++) {
                            if (isSpecial(paddedArray[i][j])) {
                                validCounter++;
                            }
                        }
                    }
                } else {
                    if (!currentNumber.isEmpty() && validCounter > 0) {
                        answer += Integer.valueOf(currentNumber);
                        currentNumber = "";
                        validCounter = 0;
                    }
                }
            }
        }

        System.out.println("Rows: " + paddedArray.length + ", Cols: " + paddedArray[0].length);
        System.out.println("Answer: " + answer);
        scanner.close();
    }

    public static boolean isSpecial(char c) {
        if (Character.isDigit(c) || Character.compare(c, '.') == 0 || c == '\0' || c == '\n') {
            return false;
        }
        return true;
    }

    public static char[][] padArray(char[][] array, int padding) {
        int rows = array.length;
        int cols = array[0].length;

        // Create a new padded array with increased dimensions
        char[][] paddedArray = new char[rows + 2 * padding][cols + 2 * padding];

        // Copy values from the original array to the padded array
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                paddedArray[i + padding][j + padding] = array[i][j];
            }
        }

        return paddedArray;
    }

}
