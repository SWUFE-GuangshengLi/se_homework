package homework;

public class Main {
    public static void main(String[] args) {

        RandomArray ran = new RandomArray(10000);

        InsertionSort insSort = new InsertionSort();
        insSort.sort(ran.getArray(5000));

        for (int j : ran.array) {
            System.out.print(j + "\t");
        }
        System.out.println();
    }
}
