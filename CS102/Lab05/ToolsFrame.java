package Lab05;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ToolsFrame extends JFrame implements ActionListener {
    public JButton clear;
    public JButton pen;
    public JButton penSize;
    public JButton laser;
    public JButton color;
    public JButton tolerance;

    public ToolsFrame() {

        clear = new JButton("Clear");
        pen = new JButton("Pen");
        penSize = new JButton("Pen Size");
        laser = new JButton("Laser");
        color = new JButton("Color");
        tolerance = new JButton("Tolerance");
        clear.addActionListener(this);
        pen.addActionListener(this);
        penSize.addActionListener(this);
        laser.addActionListener(this);
        color.addActionListener(this);
        tolerance.addActionListener(this);
        clear.addActionListener(this);
        JPanel butPanel = new JPanel();
        butPanel.add(clear);
        butPanel.add(pen);
        butPanel.add(penSize);
        butPanel.add(laser);
        butPanel.add(color);
        butPanel.add(tolerance);
        butPanel.setLayout(new BoxLayout(butPanel, BoxLayout.Y_AXIS));
        add(butPanel);
        setSize(100, 200);
        pack();
        setResizable(false);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == clear) {
            Graphics g = Controller.getBufferedImage().getGraphics();
            g.setColor(Color.white);
            g.fillRect(0, 0, Controller.getSettingsFrame().width, Controller.getSettingsFrame().height);
            Controller.getPaintFrame().repaint();
            Controller.getPaintFrame().paintedPixels = new boolean[Controller.getSettingsFrame().width][Controller.getSettingsFrame().height];
        }
        if (e.getSource() == pen) {
            Controller.getPaintFrame().currentMode = 0;
        }
        if (e.getSource() == penSize) {
            String input = JOptionPane.showInputDialog("Enter pen size:", "");
            if (input != null && !input.trim().isEmpty()) {
                try {
                    int penSize = Integer.parseInt(input);
                    Controller.getPaintFrame().setPenSize(penSize);
                } catch (NumberFormatException en) {
                    JOptionPane.showMessageDialog(null, "Invalid input. Please enter a valid integer.");
                }
            }
        }
        if(e.getSource() == color){
            Color selected = JColorChooser.showDialog(null, "Pick a Color!", Color.WHITE);
            Controller.getPaintFrame().currentColor = selected;
        }
        if(e.getSource() == tolerance){
            String input = JOptionPane.showInputDialog("Enter tolerance:", "");
            if (input != null && !input.trim().isEmpty()) {
                try {
                    int tol = Integer.parseInt(input);
                    Controller.getPaintFrame().tolerance = tol;
                } catch (NumberFormatException en) {
                    JOptionPane.showMessageDialog(null, "Invalid input. Please enter a valid integer.");
                }
            }

        }
        if(e.getSource() == laser){
            Controller.getPaintFrame().currentMode = 1;
        }

    }
}
