package homework;

import java.util.Random;

public class RandomArray {
    int[] array;

    public RandomArray(int length) {
        array = new int[length];
    }

    public int[] getArray(int max) {
        for (int i = 0; i < array.length; i++) {
            Random rand = new Random();
            array[i] = rand.nextInt(max);
        }
        return array;
    }

    /*
    public static void main(String[] args) {
        RandomArray ran = new RandomArray(500);
        int[] myArray = ran.getArray(1000);
        for (int j : myArray) {
            System.out.println(j);
        }
    }*/
}
