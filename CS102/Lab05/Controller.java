package Lab05;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.event.WindowEvent;
import java.awt.event.WindowAdapter;

public class Controller {
    public static SettingsFrame sf;
    private static PaintFrame pf;
    private static BufferedImage buff;
    private static ToolsFrame tf;

    public static void main(String[] args) {
        sf = new SettingsFrame();
   }
    public static PaintFrame getPaintFrame() {
        return pf;
   }
   public static SettingsFrame getSettingsFrame() {
        return sf;
    }
    public static BufferedImage getBufferedImage() {
        return buff;
    }
    public static ToolsFrame getToolsFrame() {
        return tf;
    }

    public static void showPaintFrame() {
        buff = new BufferedImage(getSettingsFrame().width, getSettingsFrame().height, BufferedImage.TYPE_INT_ARGB);
        tf = new ToolsFrame();
        pf = new PaintFrame(sf.width,sf.height);
        pf.setVisible(true);
        pf.addWindowListener(new WindowAdapter() {
           @Override
           public void windowClosing(WindowEvent windowEvent) {
               System.exit(0);
           }
       });
   }
   public static void showToolsFrame() {
        tf.setVisible(true);
        tf.addWindowListener(new WindowAdapter() {
            @Override
            public void windowClosing(WindowEvent windowEvent) {
                System.exit(0);
            }
        });
    }
}
