package Lab04;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Random;

public class TreePanel extends JPanel implements ActionListener {
    public int currentSeason;
    Dictionary<String, Color> colors = new Hashtable<>();
    public Timer timer;
    public int[] snowflakeX, snowflakeY, snowflakeSpeedX, snowflakeSpeedY;
    public int offset;
    public int count;

    public TreePanel() {
        count = 0;
        initializeSnowflakes();
        setSeason(0);
        colors.put("Spring", new Color(135, 206, 235));
        colors.put("Branch", new Color(0x662A16));
        colors.put("Fall", new Color(0x76ABB8));
        colors.put("Winter", new Color(0x515F6E));
        colors.put("Summer", new Color(0xACE5FD));
        timer = new Timer(50, this);
        timer.start();
    }

    public void setSeason(int s) {
        if (s == 0) {
            offset = 3;
        } else if (s == 1) {
            offset = 0;
        } else if (s == 2) {
            offset = 6;
        } else if (s == 3) {
            offset = 8;
        }
        currentSeason = s;
    }

    public void paintComponent(Graphics g) {
        super.paintComponent(g);
        paintBackground(g);
        paintLeaves(g);
        paintBranch(g);
        addFruits(g);
        paintSnowflakes(g);
        repaint();
    }

    public void paintBranch(Graphics g) {
        g.setColor(colors.get("Branch"));

        int[] xPoints = {
                275, 150, 180, 200, 140 + offset, 130 + offset, 155 + offset, 170 + offset, 195 + offset, 175 + offset,
                204 + offset, 185 + offset, 210 + offset, 228 + offset, 225 + offset, 257 + offset, 240 + offset,
                243 + offset, 315 + offset, 330 + offset, 320 + offset, 250 + offset, 240, 245
        };
        int[] yPoints = {
                350, 350, 340, 300, 220, 140, 210, 235, 165, 95, 162, 236, 250, 213, 147, 99, 150, 204, 183, 120, 194,
                227, 289, 333
        };
        Polygon a = new Polygon(xPoints, yPoints, xPoints.length);
        g.drawPolygon(a);
        g.fillPolygon(a);
    }

    public void paintLeaves(Graphics g) {
        if (currentSeason == 3) {
            return;
        }
        if (currentSeason == 0) {
            g.setColor(Color.green);
        } else if (currentSeason == 1) {
            g.setColor(Color.green);
        } else if (currentSeason == 2) {
            g.setColor(new Color(0xD4750B));
        }
        int[] xPoints = {
                330 + offset, 260 + offset, 160 + offset, 95 + offset, 70 + offset, 130 + offset, 222 + offset,
                260 + offset, 273 + offset, 295 + offset, 346 + offset, 382 + offset,
        };
        int[] yPoints = {
                215, 185, 206, 187, 122, 57, 36, 42, 93, 70, 87, 160,
        };
        Polygon a = new Polygon(xPoints, yPoints, xPoints.length);
        g.drawPolygon(a);
        g.fillPolygon(a);
    }

    public void paintBackground(Graphics g) {
        if (currentSeason == 0) {
            g.setColor(colors.get("Spring"));
        } else if (currentSeason == 1) {
            g.setColor(colors.get("Summer"));
        } else if (currentSeason == 2) {
            g.setColor(colors.get("Fall"));
        } else if (currentSeason == 3) {
            g.setColor(colors.get("Winter"));
        }
        g.fillRect(0, 0, getWidth(), getHeight());

    }

    public void addFruits(Graphics g) {
        if (currentSeason == 1) {
            g.setColor(Color.red);
            g.fillOval(330, 140, 20, 20);
            g.fillOval(270, 160, 20, 20);
            g.fillOval(200, 88, 20, 20);
            g.fillOval(150, 140, 20, 20);
            g.fillOval(110, 113, 20, 20);
        }
    }

    private void initializeSnowflakes() {
        snowflakeX = new int[50];
        snowflakeY = new int[50];
        snowflakeSpeedX = new int[50];
        snowflakeSpeedY = new int[50];

        for (int i = 0; i < 50; i++) {
            snowflakeX[i] = new Random().nextInt(440);
            snowflakeY[i] = new Random().nextInt(425);
            snowflakeSpeedX[i] = new Random().nextInt(10) - 1;
            snowflakeSpeedY[i] = new Random().nextInt(10) + 1;
        }
    }

    public void paintSnowflakes(Graphics g) {
        if (currentSeason != 3) {
            return;
        }
        g.setColor(Color.white);
        for (int i = 0; i < snowflakeX.length; i++) {
            g.fillOval(snowflakeX[i], snowflakeY[i], 5, 5);
        }
    }

    @Override
    public void actionPerformed(ActionEvent e) {
        count++;
        if(count == 20){
            offset = -offset;
            count = 0;
        }
        if (currentSeason == 3) {
            for (int i = 0; i < 50; i++) {
                snowflakeX[i] += snowflakeSpeedX[i];
                snowflakeY[i] += snowflakeSpeedY[i];

                if (snowflakeY[i] >= getHeight()) {
                    snowflakeX[i] = new Random().nextInt(getWidth());
                    snowflakeY[i] = 0;
                    snowflakeSpeedY[i] = new Random().nextInt(3) + 1;
                }
            }
        }
    }

}