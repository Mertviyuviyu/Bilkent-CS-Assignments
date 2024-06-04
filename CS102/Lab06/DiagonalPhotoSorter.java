package Lab06;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import javax.swing.*;

public class DiagonalPhotoSorter extends JFrame implements KeyListener {
    public int photoChoice;
    public ImagePanel image1,image2,image3;
    public DiagonalPhotoSorter() {
        setTitle("Image Display");
        addKeyListener(this);
        image1 = new ImagePanel("C:\\Users\\Mert\\Desktop\\Code\\102\\Lab06\\image1.png",this);
        image2 = new ImagePanel("C:\\Users\\Mert\\Desktop\\Code\\102\\Lab06\\image2.png", this);
        image3 = new ImagePanel("C:\\Users\\Mert\\Desktop\\Code\\102\\Lab06\\image3.png", this);
        add(image1);
        add(image2);
        add(image3);
        image2.setVisible(false);
        image2.Run = false;
        image3.setVisible(false);
        image3.Run = false;
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setVisible(true);
        setLayout(null);
        photoChoice = 1;
    }
    public static double getBrightness(Color c) {
        return 0.2126 * c.getRed() + 0.7152 * c.getGreen() + 0.0722 * c.getBlue();
    }

    public static void displayPhoto(int photoChoice, ImagePanel im1,ImagePanel im2,ImagePanel im3){
        im1.Run = im2.Run = im3.Run = false;
        im1.setVisible(false);
        im2.setVisible(false);
        im3.setVisible(false);
        if(photoChoice == 1){
            im1.Run = true;
            im1.setVisible(true);
        }
        else if(photoChoice == 2){
            im2.Run = true;
            im2.setVisible(true);
        }
        else{
            im3.Run = true;
            im3.setVisible(true);
        }
    }


    public static void main(String[] args){
        new DiagonalPhotoSorter();
    }

    @Override
    public void keyTyped(KeyEvent e) {

    }

    @Override
    public void keyPressed(KeyEvent e) {
        if(e.getKeyCode() == KeyEvent.VK_RIGHT){
            if(photoChoice != 3){
                photoChoice++;
            }
            else{
                photoChoice = 1;
            }
            displayPhoto(photoChoice,image1,image2,image3);
        }
        else if(e.getKeyCode() == KeyEvent.VK_LEFT){
            if(photoChoice != 1){
                photoChoice--;
            }
            else{
                photoChoice = 3;
            }
            displayPhoto(photoChoice,image1,image2,image3);
        }
        if(e.getKeyChar() == 'r'){
            if (photoChoice == 1) {
                image1.loadImage(image1.imagePath);
            }
            if (photoChoice == 2) {
                image2.loadImage(image2.imagePath);
            }
            if (photoChoice == 3) {
                image3.loadImage(image3.imagePath);
            }
        }
    }

    @Override
    public void keyReleased(KeyEvent e) {

    }
}
