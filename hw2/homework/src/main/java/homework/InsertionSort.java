package homework;

public class InsertionSort {

    //交换元素
    private void swap(int i, int j, int[] arr) {
        arr[j] ^= arr[i];
        arr[i] ^= arr[j];
        arr[j] ^= arr[i];
    }

    //寻找合适插入位置
    private int seek(int i, int[] arr) {
        int proper = i;
        for (int j = i; j > 0; j--) {
            if (arr[i] < arr[j - 1]) {
                proper = j - 1;
            } else {
                break;
            }
        }
        return proper;
    }

    //将数值交换到合适位置
    public void sort(int[] arr) {
        int n = arr.length;
        for (int i = 0; i < n; i++) {   // 寻找元素 arr[i]合适插入位置
            int proper = seek(i,arr);
            for (int j = i; j > proper; j--) {
                swap(j, j - 1, arr);
            }
        }
    }

}