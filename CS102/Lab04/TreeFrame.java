package Lab04;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;



public class TreeFrame extends JFrame implements ActionListener{
    public JButton spring;
    public JButton summer;
    public JButton fall;
    public JButton winter;
    public TreePanel tp;
    public TreeFrame(){
        tp = new TreePanel();
        this.setTitle("Ağaç");
        this.setSize(440, 425);
        this.add(tp,BorderLayout.CENTER);
        JPanel buttonPanel = new JPanel();
        spring = new JButton("Spring");
        summer = new JButton("Summer");
        fall = new JButton("Fall");
        winter = new JButton("Winter");
        spring.addActionListener(this);
        summer.addActionListener(this);
        fall.addActionListener(this);
        winter.addActionListener(this);
        buttonPanel.add(spring);
        buttonPanel.add(summer);
        buttonPanel.add(fall);
        buttonPanel.add(winter);
        this.add(buttonPanel, BorderLayout.SOUTH);
        System.out.println(buttonPanel.getHeight());
        System.out.println(getWidth());

        this.setResizable(false);

        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setVisible(true);
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        if(e.getSource() == spring){
            tp.setSeason(0);
        }
        if(e.getSource() == summer){
            tp.setSeason(1);
        }
        if(e.getSource() == fall){
            tp.setSeason(2);
        }
        if(e.getSource() == winter){
            tp.setSeason(3);
        }
    }
    
}
