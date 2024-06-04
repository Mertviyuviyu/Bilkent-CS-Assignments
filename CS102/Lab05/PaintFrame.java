package Lab05;

import javax.swing.*;
import javax.swing.event.MouseInputListener;

import java.awt.*;
import java.awt.event.*;
import java.awt.image.BufferedImage;

public class PaintFrame extends JFrame implements MouseInputListener {

    public int oldX,oldY,currentX, currentY;
    public int currentMode;
    public int penSize;
    public Color currentColor;
    public int tolerance;
    public boolean[][] paintedPixels;
    
    public PaintFrame(int width, int height){
        currentMode = 0;
        penSize = 2;
        currentColor = Color.black;
        tolerance = 10;
        paintedPixels = new boolean[width][height];
        int a = Controller.getToolsFrame().getX() + Controller.getToolsFrame().getWidth();
        int b = Controller.getToolsFrame().getY();
        setLocation(a,b);
        setResizable(false);
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setVisible(true);
        setSize(width, height);
        addMouseListener(this);
        addMouseMotionListener(this);
        Graphics2D g2d = (Graphics2D) Controller.getBufferedImage().getGraphics();
        g2d.setColor(currentColor);
        g2d.setStroke(new BasicStroke(penSize));
        Graphics g = Controller.getBufferedImage().getGraphics();
        g.setColor(Color.white);
        g.fillRect(0, 0, Controller.getSettingsFrame().width, Controller.getSettingsFrame().height);
        repaint();
    }

    public void paint(Graphics g){
        g.drawImage(Controller.getBufferedImage(), 0, 0, null);
    }
    public void setPenSize(int val){
        penSize = val;
    }
    public void laserFill(int x, int y){
        BufferedImage image = Controller.getBufferedImage();

        if (x < 0 || x >= image.getWidth() || y < 0 || y >= image.getHeight()) {
            return;
        }

        if (!isSimilarColor(new Color(image.getRGB(x, y)), currentColor)  || isPixelPainted(x, y) ) {
            return;
        }

        image.setRGB(x, y, currentColor.getRGB());
        markPixelAsPainted(x, y);

        laserFill(x, y - 1);
        laserFill(x, y + 1);
    }
    public boolean isSimilarColor(Color c1, Color c2) {
        int redDiff = Math.abs(c1.getRed()-c2.getRed());
        int blueDiff = Math.abs(c1.getBlue()-c2.getBlue());
        int greenDiff = Math.abs(c1.getGreen()-c2.getGreen());
        int tolCheck = (redDiff + blueDiff + greenDiff)/3;
        return tolCheck < tolerance;
    }

    public void markPixelAsPainted(int x, int y) {
        paintedPixels[x][y] = true;
    }
    
    public boolean isPixelPainted(int x, int y) {
        return paintedPixels[x][y];
    }
    

    @Override
    public void mouseClicked(MouseEvent e) {

    }

    @Override
    public void mousePressed(MouseEvent e) {
        oldX = e.getX();
        oldY = e.getY();

        laserFill(oldX, oldY);

        repaint();

    }

    @Override
    public void mouseReleased(MouseEvent e) {

    }

    @Override
    public void mouseEntered(MouseEvent e) {

    }

    @Override
    public void mouseExited(MouseEvent e) {

    }

    @Override
    public void mouseDragged(MouseEvent e) {

        if(currentMode == 0) {
            currentX = e.getX();
            currentY = e.getY();

            Graphics2D g2d = (Graphics2D) Controller.getBufferedImage().getGraphics();
            g2d.setStroke(new BasicStroke(penSize));
            g2d.setColor(currentColor);
            g2d.drawLine(oldX, oldY, currentX, currentY);

            oldX = currentX;
            oldY = currentY;

            repaint();
        }
        if(currentMode == 1){
            currentX = e.getX();
            currentY = e.getY();
            laserFill(currentX, currentY);
            oldX = currentX;
            oldY = currentY;
            repaint();
        }
    }

    @Override
    public void mouseMoved(MouseEvent e) {

    }
    
}
