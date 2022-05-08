public class HotPot_Factory {

    public static HotpotOrder HotPot_Factory(String orderName, String dish, int price, int index) throws Exception{
        if(orderName.equals("Bottom_HP")){
            return new HotpotType_HO(dish,price,index);
        } else if(orderName.equals("Dishes")){
            return new AdditionFood_HO(dish,price,index);
        } else if(orderName.equals("CustonerNumber_HO")){
            return new CustonerNumber_HO(dish,price,index);
        } else{
            throw new Exception("出错了！");
        }
    }
}