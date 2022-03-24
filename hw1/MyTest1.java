import java.util.ArrayList;
import java.util.List;

public class MyTest1 {

    public static void main(String[] args) {

        List arrayList = new ArrayList();
        arrayList.add("总有刁民想害朕");
        arrayList.add(7);

        for (int i = 0; i < arrayList.size(); i++) {
            Object item = arrayList.get(i);
            if (item instanceof String) {
                String str = (String) item;
                System.out.println("泛型测试 item = " + str);
            } else if (item instanceof Integer) {
                Integer inte = (Integer) item;
                System.out.println("泛型测试 item = " + inte);
            }
        }

    }

}
