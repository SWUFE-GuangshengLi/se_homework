public enum AdditionFood_CT implements ChoiceTypes {

    ADD_FOOD1("牛肚",30 , "food1"),
    ADD_FOOD2("牛肉", 35, "food2"),
    ADD_FOOD3("乌鸡卷", 15, "food3");
    // 成员变量
    private String name;
    private int price;
    private String index;

    // 构造方法
    private AdditionFood_CT(String name, int price, String index) {
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
        for (AdditionFood_CT c : AdditionFood_CT.values()) {
            if (c.getIndex().equals(index)) {
                System.out.println("菜品名称：" + this.name + "，价格为：" + this.price);
            }
        }
    }

    public String getName(String index) {
        for (AdditionFood_CT c : AdditionFood_CT.values()) {
            if (c.getIndex().equals(index)) {
                return c.name;
            }
        }
        return null;
    }

    public int getPrice(String index) {
        for (AdditionFood_CT c : AdditionFood_CT.values()) {
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
