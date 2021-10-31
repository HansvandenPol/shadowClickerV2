package shadowclicker;

import com.github.joonasvali.naturalmouse.api.MouseMotionFactory;
import com.github.joonasvali.naturalmouse.util.FactoryTemplates;

import java.awt.*;
import java.awt.event.InputEvent;
import java.awt.event.KeyEvent;
import java.util.Locale;

public class Util {
    private static Robot robot;
    private static MouseMotionFactory mouse;

    public Util() {
        try {
            robot = new Robot();
            mouse = FactoryTemplates.createAverageComputerUserMotionFactory();
        } catch (AWTException e) {
            e.printStackTrace();
        }
    }

    public void click(){
        robot.mousePress(InputEvent.BUTTON1_DOWN_MASK);

        robot.delay((int)(Math.random() * 50) + 50);

        robot.mouseRelease(InputEvent.BUTTON1_DOWN_MASK);
    }

    public void rightClick(){
        robot.mousePress(InputEvent.BUTTON3_DOWN_MASK);

        robot.delay((int)(Math.random() * 50) + 50);

        robot.mouseRelease(InputEvent.BUTTON3_DOWN_MASK);
    }

    public void mouseClick(int xPos, int yPos, boolean isFast) throws InterruptedException {
        int speed = 200;
        int offset = 100;
        if(isFast) {
            speed = 25;
            offset = 10;
        }
        System.out.println("moving mouse to x "+xPos + " and y "+ yPos);
        mouse.move(xPos, yPos);
        robot.delay((int)(Math.random() * offset) + speed);
        click();
    }

    public void mouseRightClick(int xPos, int yPos) throws InterruptedException {
        int speed = 200;
        int offset = 100;

        mouse.move(xPos, yPos);
        robot.delay((int)(Math.random() * offset) + speed);
        rightClick();
    }

    public static void pressButton(int key) {
        robot.keyPress(key);
        robot.delay((int)(Math.random() * 50) + 100);
        robot.keyRelease(key);
    }

    public void type(String text) {
        text = text.toLowerCase(Locale.ROOT);

        for(char c : text.toCharArray()) {
            int keyCode = KeyEvent.getExtendedKeyCodeForChar(c);
            robot.keyPress(keyCode);
            robot.delay((int)(Math.random() * 50) + 300);
            robot.keyRelease(keyCode);
        }
    }
}
