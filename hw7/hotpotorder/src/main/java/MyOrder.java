public class MyOrder {
    public static void main(String[] args) throws Exception {

        //HotPot_Factory.HotPot_Factory("CustonerNumber_HO","双人餐",158,0);
        float totalPrice = 0;
        //点餐，在多种中选择一个
        AllChoices myChoices = AllChoices.CUSTOMER_NUMBER2;
        String myIndex = myChoices.getIndex();
        myChoices.setNumber(myIndex,1);
        //System.out.println(myChoices.getNumber());
        HotPot_Factory.HotPot_Factory("CustonerNumber_HO",myChoices.getName(myIndex),myChoices.getPrice(myIndex),myChoices.getNumber());
        System.out.println();
        totalPrice = totalPrice +  myChoices.getPrice(myIndex) * myChoices.getNumber();

        myChoices = AllChoices.ADD_FOOD3;
        myIndex = myChoices.getIndex();
        myChoices.setNumber(myIndex,2);
        //System.out.println(myChoices.getNumber());
        HotPot_Factory.HotPot_Factory("CustonerNumber_HO",myChoices.getName(myIndex),myChoices.getPrice(myIndex),myChoices.getNumber());
        System.out.println();
        totalPrice = totalPrice +  myChoices.getPrice(myIndex) * myChoices.getNumber();

        System.out.printf("总价为：%.2f元",totalPrice);

    }

}
