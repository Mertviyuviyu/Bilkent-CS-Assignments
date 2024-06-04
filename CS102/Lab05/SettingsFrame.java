package Lab05;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class SettingsFrame extends JFrame implements ActionListener{
    public JTextField widthTextField;
    public JTextField heightTextField;
    public JButton continueBut;
    public int width;
    public int height;


    public SettingsFrame(){
        super();
        setLayout(new GridLayout(4, 2));

        JLabel widthLabel = new JLabel("Width:");
        add(widthLabel);

        widthTextField = new JTextField();
        add(widthTextField);

        JLabel heightLabel = new JLabel("Height:");
        add(heightLabel);

        heightTextField = new JTextField();
        add(heightTextField);

        continueBut = new JButton("Continue");
        continueBut.addActionListener(this);
        add(continueBut);

        setSize(300, 200);
        setResizable(false);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setVisible(true);

    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String widthStr = widthTextField.getText();
        String heightStr = heightTextField.getText();
        if(widthStr.matches("\\d+") && heightStr.matches("\\d+")){
            width = Integer.parseInt(widthStr);
            height = Integer.parseInt(heightStr);
            if(width < 1 || width > 1000 || height < 1 || height > 1000){
                JOptionPane.showMessageDialog(null, "Please enter width and height between 0 and 1000");
            }
            else{
                setVisible(false);
                Controller.showPaintFrame();
                Controller.showToolsFrame();
            }
        }
        else{
            JOptionPane.showMessageDialog(null, "Please enter both width and height with only numbers");
        }
    }
}
