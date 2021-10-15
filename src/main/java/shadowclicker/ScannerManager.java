package shadowclicker;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

public class ScannerManager {
    private static BufferedReader scanner = new BufferedReader(new InputStreamReader(System.in));

    public static BufferedReader getScanner(){
        return scanner;
    }

    public static void clear() throws IOException {
        while(scanner.ready()) {
            scanner.readLine();
        }
    }
}
