package homework;

public class InsertSort {
    int len;
    static int[] array;
    /*
    public InsertSort(int[] array, int len) {
        this.len = len;
        this.array = array;
    }*/

    public static int[] sort() {
        for (int i = 1; i < array.length; i++) {
            int temp = array[i];//保存每次需要插入的那个数
            int j;
            for (j = i; j > 0 && array[j - 1] > temp; j--) {//这个较上面有一定的优化
                array[j] = array[j - 1];//大于需要插入的数往后移动。最后不大于temp的数就空出来j
            }
            array[j] = temp;//将需要插入的数放入这个位置
        }
        return array;
    }

}
