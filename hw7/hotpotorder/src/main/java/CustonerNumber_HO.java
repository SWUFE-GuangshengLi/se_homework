public class CustonerNumber_HO implements HotpotOrder {
    //定义套餐
    public CustonerNumber_HO(String dish, int price, int index) {
        if (index >= 1){
            System.out.print(dish+"已加入购物车");
        }
        else
            System.out.print(dish+"已移除购物车");
    }
}
