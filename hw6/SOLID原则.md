# SOLIDԭ��֮Open-closed principle�����ŷ��ԭ��

## ���ŷ��ԭ������

���Ͽ��ŷ��ԭ���ģ�鶼��������Ҫ���ԣ�
1. ���� "������չ���ţ�Open For Extension��"��

Ҳ����˵ģ�����Ϊ���ܹ�����չ�ġ���Ӧ�ó��������仯ʱ�����ǿ���ʹģ����ֳ�ȫ�µĻ���������ͬ����Ϊ���������µ�����

2. ���� "�����޸ķ�գ�Closed For Modification��"��

ģ���Դ�����ǲ��ܱ��ַ��ģ��κ��˶��������޸�����Դ����

�������������������ǻ����ͻ�ģ���Ϊͨ����չģ����Ϊ�ĳ��淽ʽ�����޸ĸ�ģ�顣һ�����ܱ��޸ĵ�ģ��ͨ������Ϊ��ӵ���Ź̶�����Ϊ����ô���ʹ�������෴�����Թ����أ�

**����**�ǹؼ���

��ʹ�����������Ƽ���ʱ�����Դ����̶��ĳ����һ�����޽�Ŀ�����Ϊ������������ĳ���ָ���ǳ�����࣬�����޽�Ŀ�����Ϊ��������������������������ʾ��Ϊ��һ��ģ����۸�һ�����������п��ܵģ���������ģ������Զ��޸ķ�գ���Ϊ��������һ���̶��ĳ���Ȼ�����ģ�����Ϊ����ͨ���������������������չ��

## ʾ��
### Client/Server����

��ͼ��ʾ��`Client` �� `Server` �඼�Ǿ����ࣨConcrete Class���������޷���֤ `Server` �ĳ�Ա�������麯���� ���� `Client` ��ʹ���� `Server` �ࡣ����������� `Client` ����ʹ��һ����ͬ�� `Server` ������ô�����޸� `Client` ����ʹ���µ� `Server` ��Ͷ���
![��յ�Client](1.png)

����ͼ��ʾ���У�`AbstractServer` ����һ�������࣬������һ�������Ա������`Client` ��������������󣬵� `Client` �ཫʹ�������� `Server` ��Ķ���ʵ�������������Ҫ `Client` ����ʹ��һ����ͬ�� `Server` �࣬����Դ� `AbstractServer` ��������һ���µ����࣬�� `Client` ������Ȼ���ֲ��䡣
![���ŵ�Clien](2.png)

### Shape����
������һ��Ӧ�ó�����Ҫ�ڱ�׼ GUI �����ϻ���Բ�Σ�Circle���ͷ��Σ�Square����Բ�κͷ��α������ض���˳����л��ơ�Բ�κͷ��λᱻ������ͬһ���б��У��������ʵ���˳�򣬶���������ܹ�˳������б��������е�Բ�κͷ��Ρ�

������δ���չʾ�˷��Ͽ��ŷ��ԭ��� Cicle/Square �����һ�����������

```Java
public abstract class Shape {
    public abstract void Draw();
}

public class Circle : Shape {
    public override void Draw() {
      // draw circle on GUI
    }
}

public class Square : Shape {
    public override void Draw() {
      // draw square on GUI
    }
}

public class Client {
    public void DrawAllShapes(List<Shape> shapes) {
        foreach (var shape in shapes) {
            shape.Draw();
        }
    }
}
```
�������Ӵ�����һ�� `Shape` �����࣬������������һ�����麯�� `Draw`���� `Circle` �� `Square` �������� `Shape` �ࡣ

����Ҫ��չ `DrawAllShapes` ��������Ϊ������һ���µ�ͼ�����࣬����Ҫ���ľ�������һ���� `Shape` �����������ࡣ��`DrawAllShapes` ��������������޸ġ����`DrawAllShapes` �����˿��ŷ��ԭ��������Ϊ���Բ�ͨ�������޸Ķ���չ��

�ڱȽ���ʵ������У�`Shape` ����ܰ����ܶ��������������Ӧ�ó���������һ���µ�ͼ����Ȼ�Ƿǳ��򵥵ģ���Ϊ����Ҫ���Ľ��Ǵ���һ����������ʵ����Щ������ͬʱ������Ҳ������Ҫ��Ӧ�ó����ڲ���������Ҫ�޸ĵ�λ���ˡ�

## �����Եıպϣ�Strategic Closure��
��ȫ�պ��ǲ���ʵ�ģ����Ա��뽲�����ԡ�Ҳ����˵���������ʦ�����������ƶ���Щ�仯��ա�����ҪһЩ���ھ����Ԥ�⡣�о�������ʦ��ܺõ��˽��û������ڵ���ҵ�����жϸ��ֱ仯�Ŀ����ԡ�Ȼ�����ȷ�������п��ܵı仯���ֿ��ŷ��ԭ��

һ��������Ծ��ǣ����������������󣬿��Է�����һ��Ӧ�����Ȼ��ơ���ˣ����ǿ����� `Shape` �ж���һ����Ϊ `Precedes` �ķ����������Խ�����һ�� `Shape` ��Ϊ����������һ�� `bool` ���͵Ľ����������Ϊ `true` ���ʾ���յ��õ� `Shape` ����Ӧ���ڱ���Ϊ������ `Shape` �����ǰ�档

���ǿ���ʹ�����ز�����������ʵ�������ıȽϹ��ܡ�����ͨ���Ƚ����ǾͿ��Եõ����� `Shape` ��������˳��Ȼ�������Ϳ��԰���˳����л��ơ�

������ʾ�˼�ʵ�ֵĴ��롣
```Java
public abstract class Shape {
    public abstract void Draw();
    public bool Precedes(Shape another) {
        if (another is Circle)
            return true;
        else
            return false;
    }
}

public class Circle : Shape {
    public override void Draw() {
      // draw circle on GUI
    }
}

public class Square : Shape {
    public override void Draw() {
      // draw square on GUI
    }
}

public class ShapeComparer : IComparer<Shape> {
    public int Compare(Shape x, Shape y) {
      return x.Precedes(y) ? 1 : 0;
    }
}

public class Client {
    public void DrawAllShapes(List<Shape> shapes) {
        SortedSet<Shape> orderedList = new SortedSet<Shape>(shapes, new ShapeComparer());
        foreach (var shape in orderedList) {
            shape.Draw();
        }
    }
}
```
### ʹ�� "����������Data Driven��" �ķ�������ɱպ�

ʹ�ñ�������Table Driven�������ܹ���ɶ� `Shape` ������ıպϣ�������ǿ���޸�ÿ�������ࡣ

����չʾ��һ�ֿ��ܵ���ơ�
```Java
private Dictionary<Type, int> _typeOrderTable = new Dictionary<Type, int>();

private void Initialize() {
      _typeOrderTable.Add(typeof(Circle), 2);
      _typeOrderTable.Add(typeof(Square), 1);
}

public bool Precedes(Shape another) {
      return _typeOrderTable[this.GetType()] > _typeOrderTable[another.GetType()];
}
```
ͨ��ʹ�����ַ��������Ѿ��ɹ���ʹ `DrawAllShapes` ������һ������¶��������Ᵽ�ַ�գ�����ÿ�� `Shape` �������඼���µ� `Shape` �������������Ե��޸ģ������޸����������ʹ�Ȼ��� Square���ȱ��ַ�ա�
## �ܽ�

���ڿ��ŷ��ԭ��*Open Closed Principle*�����кܶ���Խ��ġ��ںܶ෽�����ԭ�������������Ƶĺ��ġ�ʼ����ѭ��ԭ����ܴ�����������г����ػ�������洦�����磺�������ԺͿ�ά���ԡ�ͬʱ���Ը�ԭ�����ѭҲ����ͨ��ʹ��һ���������ı�����Ծ��ܹ���ɵġ���ȷ�е�˵������Ҫ�������ʦ��רע�ڽ�������Ӧ�õ���������Щ���ڱ仯�Ĳ����ϡ�

## �ο�����
[���ŷ��ԭ��Open Closed Principle��](https://www.cnblogs.com/gaochundong/p/open_closed_principle.html)