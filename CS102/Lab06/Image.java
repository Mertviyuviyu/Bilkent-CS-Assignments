package Lab06;

import java.awt.*;
import java.util.LinkedList;
import java.util.List;

public class Image {
    public int width, height;
    public Color[][] pixels;

    public Image(Color[][] px, int w, int h) {
        width = w;
        height = h;
        pixels = px;
    }

    public void iterativeDiagonalSelectionSort(int iterationCount) {
        for (int i = -height + 1; i < width - 1; i++) {
            Color[] newDiag = extractDiagonal(i, iterationCount);
            reverseSelectionSort(newDiag);
            reInsertDiagonal(i, newDiag);
        }
    }

    public void reInsertDiagonal(int diagNumber, Color[] diagonal) {
        if (diagNumber >= 0) {
            for (int i = 0; i < diagonal.length; i++) {
                pixels[i+diagNumber][i] = diagonal[i];
            }
        }
        if (diagNumber < 0) {
            for (int i = 0; i < diagonal.length; i++) {
                pixels[i][i - diagNumber] = diagonal[i];
            }
        }
    }
    public static void reverseSelectionSort(Color[] arr) {
        int n = arr.length;

        for (int i = 0; i < n - 1; i++) {
            int maxIndex = i;

            // Find the index of the maximum element in the unsorted part of the array
            for (int j = i + 1; j < n; j++) {
                if (DiagonalPhotoSorter.getBrightness(arr[j]) > DiagonalPhotoSorter.getBrightness(arr[maxIndex])) {
                    maxIndex = j;
                }
            }

            // Swap the found maximum element with the last element in the unsorted part
            Color temp = arr[maxIndex];
            arr[maxIndex] = arr[i];
            arr[i] = temp;
        }
    }

    // Diagnumber varies from -height to +width
    public Color[] extractDiagonal(int diagnumber, int iterationCount) {
        List<Color> diagonal = new LinkedList<>();
        if (diagnumber >= 0) {
            int elements = Math.min(Math.min(width - diagnumber, height),iterationCount);
            for (int i = 0; i < elements; i++) {
                diagonal.add(pixels[i+diagnumber][i]);
            }
        }
        if (diagnumber < 0) {
            int elements = Math.min(Math.min(width, height + diagnumber), iterationCount);
            for (int i = 0; i < elements; i++) {
                diagonal.add(pixels[i][i - diagnumber]);
            }
        }
        Color[] arr = diagonal.toArray(new Color[0]);
        return arr;
    }
}
