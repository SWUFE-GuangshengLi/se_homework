public enum HotpotType_CT implements ChoiceTypes {
    H_TYPE1("牛肉火锅", 80,"h_type1"),
    H_TYPE2("羊肉火锅", 70,"h_type2"),
    H_TYPE3("鱼肉火锅", 50,"h_type3");
    // 成员变量
    private String name;
    private int price;
    private String index;

    // 构造方法
    private HotpotType_CT(String name, int price, String index) {
        this.name = name;
        this.price = price;
        this.index=index;
    }

    //接口方法
    public String getIndex() {
        return index;
    }

    public String getName(String index) {
        for (HotpotType_CT c : HotpotType_CT.values()) {
            if (c.getIndex().equals(index)) {
                return c.name;
            }
        }
        return null;
    }

    public int getPrice(String index) {
        for (HotpotType_CT c : HotpotType_CT.values()) {
            if (c.getIndex().equals(index)) {
                return c.price;
            }
        }
        return 0;
    }

    @Override
    public void setNumber(String a, int b) {

    }

    //接口方法
    @Override
    public void print(String index) {
        for (HotpotType_CT c : HotpotType_CT.values()) {
            if (c.getIndex().equals(index)) {
                System.out.println("菜品名称："+this.name+"，价格为："+this.price);
            }
        }
    }
}
