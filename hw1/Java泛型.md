# Java泛型

## 概述
泛型的本质是参数化类型，即给类型指定一个参数，然后在使用时再指定此参数具体的值，那样这个类型就可以在使用时决定了。这种参数类型可以用在类、接口和方法中，分别被称为泛型类、泛型接口、泛型方法。
## 泛型意义
Java中引入泛型最主要的目的是将**类型检查**工作提前到编译时期，将**类型强转**`cast`工作交给编译器，从而让你在编译时期就获得类型转换异常以及去掉源码中的类型强转代码。
### 没有泛型前
```Java
private static void genericTest() {
    List arrayList = new ArrayList();
    arrayList.add("总有刁民想害朕");
    arrayList.add(7);

    for (int i = 0; i < arrayList.size(); i++) {
        Object item = arrayList.get(i);
        if (item instanceof String) {
            String str = (String) item;
            System.out.println("泛型测试 item = " + str);
        }else if (item instanceof Integer)
        {
            Integer inte = (Integer) item;
            System.out.println("泛型测试 item = " + inte);
        }
    }
}
```
如上代码所示，在没有泛型之前**类型的检查**和**类型的强转**都必须由程序员自己负责，一旦犯了错，如`Integer`类型的对象强行转换成`String`类型，就是导致运行崩溃。

### 使用泛型
```Java
private static void genericTest2() {
     List<String> arrayList = new ArrayList<>();
     arrayList.add("总有刁民想害朕");
     arrayList.add(7); //..(参数不匹配：int无法转换为String)
     ...
 }
 ```
 如上代码，编译器在编译时期即可完成类型检查工作，并提出错误（其实IDE在代码编辑过程中已经报红了），这是一个只能放入`String`类型的列表，无法放入`Int`类型。

 ## 泛型作用的对象
泛型有三种使用方式，分别为：
- 泛型类；
- 泛型接口
- 泛型方法。

### 1. 泛型类
在类的申明时指定参数，即构成了泛型类，例如下面代码中就指定`T`为类型参数，那么在这个类里面就可以使用这个类型了。例如申明`T`类型的变量`name`，申明`T`类型的形参`param`等操作。
```Java
public class Generic<T> {
    public T name;
    public Generic(T param){
        name=param;
    }
    public T m(){
        return name;
    }
}
```
那么在使用类时就可以传入相应的类型，构建不同类型的实例，如下面代码分别传入了`String`，`Integer`，`Boolean`3个类型：
```Java
private static void genericClass()
 {
     Generic<String> str=new Generic<>("总有刁民想害朕");
     Generic<Integer> integer=new Generic<>(110);
     Generic<Boolean> b=new Generic<>(true);

     System.out.println("传入类型："+str.name+"  "+integer.name+"  "+b.name);
}
```
输出结果为：

`传入类型：总有刁民想害朕 110 true`

如果没有泛型，我们想要达到上面的效果需要定义三个类，或者一个包含三个构造函数，三个取值方法的类。

### 2. 泛型接口
泛型接口与泛型类的定义基本一致
```Java
public interface Generator<T> {
    public T produce();
}
```
### 3. 泛型方法
泛型方法相对来说就比较复杂，但抓住特点后没有那么难。
```Java
public class Generic<T> {
    public T name;
    public  Generic(){}
    public Generic(T param){
        name=param;
    }
    public T m(){
        return name;
    }
    public <E> void m1(E e){ }
    public <T> T m2(T e){ }
}
```
重点看`public <E> void m1(E e){ }`，这就是一个泛型方法，判断一个方法是否是泛型方法关键看方法返回值前面有没有使用`<>`标记的类型，有就是，没有就不是。这个`<>`里面的类型参数就相当于为这个方法声明了一个类型，这个类型可以在此方法的作用块内自由使用。 上面代码中，`m()`方法不是泛型方法，`m1()`与`m2()`都是。值得注意的是`m2()`方法中声明的类型`T`与类申明里面的那个参数`T`不是一个，也可以说方法中的`T`隐藏了类型中的`T`。下面代码中类里面的`T`传入的是`String`类型，而方法中的`T`传入的是`Integer`类型。
```Java
Generic<String> str=new Generic<>("总有刁民想害朕");
str.m2(123);
```
## 泛型的使用方法
### 泛型类继承
如果不传入具体的类型，则子类也需要指定类型参数，代码如下：
```Java
class Son<T> extends Generic<T>{}
```
如果传入具体参数，则子类不需要指定类型参数
```Java
class Son extends Generic<String>{}
```
### 泛型类接口实现
```Java
class ImageGenerator<T> implements Generator<T>{
    @Override
    public T produce() {
        return null;
    }
}
```
### 泛型方法调用
和调用普通方法一致，不论是实例方法还是静态方法。
### 通配符?
`?`代表任意类型，例如有如下函数：
```Java
public void m3(List<?>list){
    for (Object o : list) {
        System.out.println(o);
    }
}
```
其参数类型是`?`，那么我们调用的时候就可以传入任意类型的`List`，如下：
```Java
str.m3(Arrays.asList(1,2,3));
str.m3(Arrays.asList("总有刁民","想害","朕"));
```
单独一个`?`意义不大，因为从集合中获取到的对象的类型是`Object`类型的，也就只有几个默认方法可调用，几乎没什么用。如果你想要使用传入的类型那就需要**强制类型转换**。泛型真正强大之处是可以通过设置其上下限达到类型的灵活使用。

---
<b>1. 通配符上界</b>

通配符上界使用`<? extends T>`的格式，意思是需要一个`T`类型或者`T`类型的子类，一般`T`类型都是一个具体的类型，例如下面的代码。
```Java
public void printIntValue(List<? extends Number> list) {  
    for (Number number : list) {  
        System.out.print(number.intValue()+" ");   
    }  
}
```
这个意义就非凡了，无论传入的是何种类型的集合，我们都可以使用其父类的方法统一处理。

---
<b>2. 通配符下界</b>

通配符下界使用`<? super T>`的格式，意思是需要一个`T`类型或者`T`类型的父类，一般`T`类型都是一个具体的类型，例如下面的代码。
```Java
public void fillNumberList(List<? super Number> list) {  
    list.add(new Integer(0));  
    list.add(new Float(1.0));  
}
```
至于什么时候使用通配符上界，什么时候使用下界，在<b>《Effective Java》</b>中有很好的指导意见：遵循**PECS**原则，即**producer-extends**，**consumer-super**。 换句话说，如果参数化类型表示一个生产者，就使用 `<? extends T>`；如果参数化类型表示一个消费者，就使用`<? super T>`。

---
### 泛型在静态方法中的问题
泛型类中的静态方法和静态变量不可以使用泛型类所声明的泛型类型参数，例如下面的代码编译失败。
```Java
public class Test<T> {      
    public static T one;   //编译错误      
    public static  T show(T one){ //编译错误      
        return null;      
    }      
}
```
因为静态方法和静态变量属于类所有，而泛型类中的泛型参数的实例化是在创建泛型类型对象时指定的，所以如果不创建对象，根本无法确定参数类型。但是静态泛型方法是可以使用的，我们前面说过，泛型方法里面的那个类型和泛型类那个类型完全是两回事。
```Java
public static <T>T show(T one){   
     return null;      
 }
```

## Java泛型原理解析
为什么人们会说Java的泛型是**伪泛型**呢，就是因为Java在编译时擦除了所有的泛型信息，所以Java根本不会产生新的类型到字节码或者机器码中，所有的泛型类型最终都将是一种**原始类型**，那样在Java运行时根本就获取不到泛型信息。
### 擦除
Java编译器编译泛型的步骤： 
1. **检查**泛型的类型 ，获得目标类型 
2. **擦除**类型变量，并替换为限定类型（`T`为无限定的类型变量，用`Object`替换） 
3. 调用相关函数，并将结果**强制转换**为目标类型
```Java
    ArrayList<String> arrayString=new ArrayList<String>();     
    ArrayList<Integer> arrayInteger=new ArrayList<Integer>();     
    System.out.println(arrayString.getClass()==arrayInteger.getClass());
```
上面代码输入结果为`true`，可见通过运行时获取的类信息是完全一致的，泛型类型被擦除了！

如何擦除： 当擦除泛型类型后，留下的就只有**原始类型**了，例如上面的代码，原始类型就是`ArrayList`。擦除类型变量，并替换为限定类型（`T`为无限定的类型变量，用`Object`替换），如下所示：
#### 擦除之前：
```Java
//泛型类型  
class Pair<T> {    
    private T value;    
    public T getValue() {    
        return value;    
    }    
    public void setValue(T  value) {    
        this.value = value;    
    }    
}
```
#### 擦除之后：
```Java
//原始类型  
class Pair {    
    private Object value;    
    public Object getValue() {    
        return value;    
    }    
    public void setValue(Object  value) {    
        this.value = value;    
    }    
}
```
因为在`Pair<T>`中，`T`是一个无限定的类型变量，所以用`Object`替换。如果是`Pair<T extends Number>`，擦除后，类型变量用`Number`类型替换。
## 与其他语言相比较
相比较***Java***，其模仿者<B><I>C#</I></B>在泛型方面无疑做的更好，其是真泛型。

C#泛型类在编译时，先生成中间代码`IL`，通用类型`T`只是一个占位符。在实例化类时，根据用户指定的数据类型代替`T`并由即时编译器（JIT）生成本地代码，这个本地代码中已经使用了实际的数据类型，等同于用实际类型写的类，所以不同的封闭类的本地代码是不一样的。其可以在运行时通过反射获得泛型信息，而且C#的泛型大大提高了代码的执行效率。

那么Java为什么不采用类似C#的实现方式呢，答案是：向下兼容！

关于C#与Java的泛型比较，可以查看这篇文章：[Comparing Java and C# Generics](http://www.jprl.com/Blog/archive/development/2007/Aug-31.html)
## 参考链接
[秒懂Java泛型](https://zhuanlan.zhihu.com/p/64585072)

[Java泛型深入理解](https://blog.csdn.net/sunxianghuang/article/details/51982979#commentsedit)

<p align="center"><img src="Java.jpg" width="25%" height="25%"></p>