package shadowclicker;


import java.awt.event.KeyEvent;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.time.LocalDate;
import java.util.Scanner;
import java.util.stream.Stream;

public class Main{
    private static boolean running = true;
    private static final Path DOC_PATH = Paths.get("/tmp/workerQ.txt");

    public static void main(String[] args) throws InterruptedException, IOException {
        System.out.println("Started");
        while(running){
            if(Files.exists(DOC_PATH)) {
            try (Stream<String> stream = Files.lines( DOC_PATH, StandardCharsets.UTF_8)) {
               stream.findFirst().ifPresent(record -> {
                   if(record.contains("RIGHT_CLICK")) {
                       String type = record.split("-")[0];
                       final String clickLocation = record.split("-")[1];
                       int x = Integer.parseInt(clickLocation.split(":")[0]);
                       int y = Integer.parseInt(clickLocation.split(":")[1].split(";")[0]);
                       int timeout = Integer.parseInt(clickLocation.split(";")[1]);

                       try {
                           Util u = new Util();
                           u.mouseRightClick(x, y);
                           Thread.sleep(timeout);
                       } catch (InterruptedException e) {
                           e.printStackTrace();
                       }
                   } else if (record.contains(":") && record.contains(";")) {
                        int x = Integer.parseInt(record.split(":")[0]);
                        int y = Integer.parseInt(record.split(":")[1].split(";")[0]);
                        int timeout = Integer.parseInt(record.split(";")[1]);

                        try {
                            Util u = new Util();
                            u.mouseClick(x, y, false);
                            Thread.sleep(timeout);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    } else if(record.contains("TYPE")) {
                        final String text = record.split(":")[1];
                        final int timeout = Integer.parseInt(record.split(":")[2]);

                        try {
                            Util u = new Util();
                            u.type(text);
                            Thread.sleep(timeout);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    } else {
                        if(record.contains("SPACE_BAR")) {
                            Util.pressButton(KeyEvent.VK_SPACE);
                            final int timout = Integer.parseInt(record.split(":")[1]);
                            try {
                                Thread.sleep(timout);
                            } catch (InterruptedException e) {
                                e.printStackTrace();
                            }
                        } else if(record.contains("ESCAPE")) {
                            Util.pressButton(KeyEvent.VK_ESCAPE);
                            final int timout = Integer.parseInt(record.split(":")[1]);
                            try {
                                Thread.sleep(timout);
                            } catch (InterruptedException e) {
                                e.printStackTrace();
                            }
                        } else if(record.contains("ENTER")) {
                            Util.pressButton(KeyEvent.VK_ENTER);
                            final int timout = Integer.parseInt(record.split(":")[1]);
                            try {
                                Thread.sleep(timout);
                            } catch (InterruptedException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                });

                Files.write(DOC_PATH, "".getBytes(), StandardOpenOption.TRUNCATE_EXISTING);
            }  catch (IOException e)
            {
                e.printStackTrace();
            }
            }


            Thread.sleep(500);
        }

    }
}
