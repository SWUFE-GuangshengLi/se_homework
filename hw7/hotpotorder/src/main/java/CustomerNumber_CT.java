public enum CustomerNumber_CT implements ChoiceTypes {

    CUSTOMER_NUMBER1("单人套餐", 98, "num1"),
    CUSTOMER_NUMBER2("双人餐", 158, "num2"),
    CUSTOMER_NUMBER3("四人餐", 258, "num3");
    // 成员变量
    private String name;
    private int price;
    private String index;

    // 构造方法
    private CustomerNumber_CT(String name, int price, String index) {
        this.name = name;
        this.price = price;
        this.index = index;
    }

    //接口方法
    public String getIndex() {
        return index;
    }

    @Override
    public void print(String a) {
        for (CustomerNumber_CT c : CustomerNumber_CT.values()) {
            if (c.getIndex().equals(index)) {
                System.out.println("菜品名称：" + this.name + "，价格为：" + this.price);
            }
        }
    }

    public String getName(String index) {
        for (CustomerNumber_CT c : CustomerNumber_CT.values()) {
            if (c.getIndex().equals(index)) {
                return c.name;
            }
        }
        return null;
    }

    public int getPrice(String index) {
        for (CustomerNumber_CT c : CustomerNumber_CT.values()) {
            if (c.getIndex().equals(index)) {
                return c.price;
            }
        }
        return 0;
    }

    @Override
    public void setNumber(String a, int b) {

    }
}
