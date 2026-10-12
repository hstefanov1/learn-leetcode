import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayDeque;
import java.util.Deque;

public class Solution {

    static void main() throws IOException {
        Path file = Path.of("problems/easy/20-valid-parentheses/examples.csv").toAbsolutePath();
        try (var reader = Files.newBufferedReader(file, StandardCharsets.UTF_8)) {
            String line;
            int counter = 0;
            long start, duration = 0;
            Solution solution = new Solution();
            System.out.printf("%nRunning tests...%n");
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");

                String title = parts[0];
                String input = parts[1];
                boolean output = Boolean.parseBoolean(parts[2]);

                System.out.print(" > " + title);
                start = System.currentTimeMillis();
                boolean result = solution.isValid(input);
                duration += System.currentTimeMillis() - start;
                System.out.println(": " + (output == result ? "OK" : "FAIL"));
                counter++;
            }
            System.out.printf("Tests completed!%n%n");
            System.out.printf("Total time: %d ms%n", duration);
            if (counter > 0) {
                System.out.printf("Avg/test: %.2f ms (%d tests)%n", (double) duration / counter, counter);
            }
        }
    }

    public boolean isValid(String s) {
        char[] data = s.toCharArray();
        if (data.length < 2) {
            return false;
        }

        Deque<Character> d = new ArrayDeque<>();

        for (char c : data) {
            if (c == '(') {
                d.push(')');
            } else if (c == '[') {
                d.push(']');
            } else if (c == '{') {
                d.push('}');
            } else if (!d.isEmpty()) {
                char c2 = d.pop();
                if (c2 != c) {
                    return false;
                }
            } else {
                return false;
            }
        }

        return d.isEmpty();
    }
}
