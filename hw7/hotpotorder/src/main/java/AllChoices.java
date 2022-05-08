public enum AllChoices implements ChoiceTypes {

    H_TYPE1("牛肉火锅", 80,"h_type1",0),
    H_TYPE2("羊肉火锅", 70,"h_type2",0),
    H_TYPE3("鱼肉火锅", 50,"h_type3",0),
    ADD_FOOD1("牛肚",30 , "food1",0),
    ADD_FOOD2("牛肉", 35, "food2",0),
    ADD_FOOD3("乌鸡卷", 15, "food3",0),
    CUSTOMER_NUMBER1("单人套餐", 98, "num1",0),
    CUSTOMER_NUMBER2("双人餐", 158, "num2",0),
    CUSTOMER_NUMBER3("四人餐", 258, "num3",0);

    // 成员变量
    private String name;
    private int price;
    private String index;
    private int number;
    // 构造方法
    private AllChoices(String name, int price, String index, int number) {
        this.name = name;
        this.price = price;
        this.index=index;
        this.number=number;
    }
    //接口方法
    public String getIndex() {
        return index;
    }
    public int getNumber() {
        return number;
    }

    @Override
    public void print(String a) {

    }

    public String getName(String index) {
        for (AllChoices c : AllChoices.values()) {
            if (c.getIndex().equals(index)) {
                return c.name;
            }
        }
        return null;
    }
    public int getPrice(String index) {
        for (AllChoices c : AllChoices.values()) {
            if (c.getIndex().equals(index)) {
                return c.price;
            }
        }
        return 0;
    }

    public void setNumber(String a_index,int a){
        for (AllChoices c : AllChoices.values()) {
            if (c.getIndex().equals(a_index)) {
               c.number=a;
            }
        }
    }
}
