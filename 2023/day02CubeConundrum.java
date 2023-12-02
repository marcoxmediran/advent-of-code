import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

public class day02CubeConundrum {
    public static void main(String[] args) throws FileNotFoundException {
        Scanner scanner = new Scanner(new FileReader("day02Input.txt"));
        ArrayList<String> inputStrings = new ArrayList<>();
        while (scanner.hasNext()) {
            inputStrings.add(scanner.nextLine());
        }
        
        // part 2
        int answer = 0;
        for (int i = 0; i < inputStrings.size(); i++) {
            String line = inputStrings.get(i);
            ArrayList<Integer> highestPerColor = getHighest(line);
            answer += getPower(highestPerColor);
        }
        System.out.println(answer);

        // part 1
        // int answer = 0;
        // for (int i = 0; i < inputStrings.size(); i++) {
        //     String line = inputStrings.get(i);
        //     if (checkIfValid(line)) {
        //         answer += getGameId(line);
        //     }
        // }

        // System.out.println(answer);
        // scanner.close();
    }

    // part 2
    public static ArrayList<Integer> getHighest(String line) {
        ArrayList<Integer> highestPerColor = new ArrayList<>();
        int highestRed = 0, highestGreen = 0, highestBlue = 0;

        String fixedLine = line.substring(line.indexOf(":") + 2);
        String[] rawIterations = fixedLine.split("; ");
        ArrayList<String> gameIterations = new ArrayList<>(Arrays.asList(rawIterations));

        // per semicolon
        for (int i = 0; i < gameIterations.size(); i++) {
            String currentIteration = gameIterations.get(i);
            String[] cubePool = currentIteration.split(", ");
            // per comma
            for (int j = 0; j < cubePool.length; j++) {
                String currentExample = cubePool[j];
                int currentRed = 0, currentGreen = 0, currentBlue = 0;
                int currentCount = Integer.valueOf(currentExample.substring(0, currentExample.indexOf(" ")));
                String currentColor = currentExample.substring(currentExample.indexOf(" ") + 1);
                switch (currentColor) {
                    case "red":
                        currentRed += currentCount;
                        break;
                    case "green":
                        currentGreen += currentCount;
                        break;
                    case "blue":
                        currentBlue += currentCount;
                        break;
                    default:
                        break;
                }
                if (currentRed > highestRed) {highestRed = currentRed;}
                if (currentGreen > highestGreen) {highestGreen = currentGreen;}
                if (currentBlue > highestBlue) {highestBlue = currentBlue;}
            }
        }
        highestPerColor.add(highestRed);
        highestPerColor.add(highestGreen);
        highestPerColor.add(highestBlue);
        return highestPerColor;
    }

    public static int getPower(ArrayList<Integer> highestPerColor) {
        int power = 1;
        for (Integer element : highestPerColor) {
            power *= element;
        }
        return power;
    }

    // part 1
    public static boolean checkIfValid(String line) {
        int maxRed = 12, maxGreen = 13, maxBlue = 14;

        String fixedLine = line.substring(line.indexOf(":") + 2);
        String[] rawIterations = fixedLine.split("; ");
        ArrayList<String> gameIterations = new ArrayList<>(Arrays.asList(rawIterations));

        // per semicolon
        for (int i = 0; i < gameIterations.size(); i++) {
            String currentIteration = gameIterations.get(i);
            String[] cubePool = currentIteration.split(", ");
            // per comma
            for (int j = 0; j < cubePool.length; j++) {
                String currentExample = cubePool[j];
                int currentRed = 0, currentGreen = 0, currentBlue = 0;
                int currentCount = Integer.valueOf(currentExample.substring(0, currentExample.indexOf(" ")));
                String currentColor = currentExample.substring(currentExample.indexOf(" ") + 1);
                switch (currentColor) {
                    case "red":
                        currentRed += currentCount;
                        break;
                    case "green":
                        currentGreen += currentCount;
                        break;
                    case "blue":
                        currentBlue += currentCount;
                        break;
                    default:
                        break;
                }
                
                if (currentRed > maxRed) {
                    return false;
                } else if (currentGreen > maxGreen) {
                    return false;
                } else if (currentBlue > maxBlue) {
                    return false;
                } else {
                    continue;
                }
            }
        }

        return true;
    }

    public static int getGameId(String line) {
        String id = line.substring(5, line.indexOf(":"));
        return Integer.valueOf(id);
    }

}
