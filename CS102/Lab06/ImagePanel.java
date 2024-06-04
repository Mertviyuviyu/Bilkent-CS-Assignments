package Lab06;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.*;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;
import java.awt.image.BufferedImage;
import java.io.File;

public class ImagePanel extends JPanel {

    public BufferedImage buff;
    public Color[][] colorsOfImage;
    public int iterationCount;
    public double factor;
    private int imageWidth, imageHeight;
    public boolean Run;
    public String imagePath;
    public ImagePanel(String imagePath, JFrame parent) {
        Run = true;
        this.imagePath = imagePath;
        loadImage(this.imagePath);
        parent.setSize(imageWidth, imageHeight);
        parent.addComponentListener(new ComponentAdapter() {
            public void componentResized(ComponentEvent e) {
                    factor = Math.min(((double) parent.getWidth()) / ((double)imageHeight), ((double) parent.getHeight()) / ((double)imageHeight));
                    setSize((int)(factor * imageWidth), (int)(factor * imageHeight));
                }
            }
        );
    }

    public void loadImage(String path) {
        try {
            buff = ImageIO.read(new File(path));
        }
        catch (Exception e) {}
        setSize((int)(factor * imageWidth), (int)(factor * imageHeight));
        this.imageWidth = buff.getWidth();
        this.imageHeight = buff.getHeight();
        iterationCount = 0;
        colorsOfImage = new Color[imageWidth][imageHeight];
        for (int i = 0; i < imageWidth; i++) {
            for (int j = 0; j < imageHeight; j++) {
                Color col = new Color(buff.getRGB(i, j));
                colorsOfImage[i][j] = col;
            }
        }
    }

    public void paint(Graphics g) {
        super.paint(g);

        Image im1 = new Image(colorsOfImage, imageWidth, imageHeight);

        if (iterationCount < im1.width * im1.height && Run) {
            im1.iterativeDiagonalSelectionSort(iterationCount);
            iterationCount++;
            for (int k = 0; k < imageWidth; k++) {
                for (int l = 0; l < imageHeight; l++) {
                    Color c = im1.pixels[k][l];
                    buff.setRGB(k, l, c.getRGB());
                }
            }
        }
        g.drawImage(buff, 0, 0, (int) (factor * imageWidth), (int) (factor * imageHeight), null);
        repaint();
    }
}