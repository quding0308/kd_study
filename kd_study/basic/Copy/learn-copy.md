##  ObjC中的拷贝

### 深拷贝与浅拷贝

对象拷贝有两种方式：

- 浅拷贝(Shallow Copy)
- 深拷贝(Deep Copy)


#### 浅拷贝

指针拷贝，只拷贝指向对象的指针。

当创建浅拷贝的时候，在原始集合里的对象就会发送retain消息，引用计数器加1，然后再拷贝指针到新的集合对象中

#### 深拷贝

深拷贝是直接拷贝整个对象内存到另一块内存中。

调用了 copyWithZone: 或 mutableCopyWithZone: 的都是深拷贝


### copy与mutableCopy的操作是浅拷贝还是深拷贝？

在非集合类对象中：对immutable对象进行copy操作，是指针拷贝，mutableCopy操作时内容拷贝；对mutable对象进行copy和mutableCopy都是内容拷贝。

用代码简单表示如下：
```
    [immutableObject copy] // 浅拷贝
    [immutableObject mutableCopy] //深拷贝
    [mutableObject copy] //深拷贝
    [mutableObject mutableCopy] //深拷贝
```

在集合类对象中，对immutable对象进行copy，是指针拷贝，mutableCopy是内容拷贝；对mutable对象进行copy和mutableCopy都是内容拷贝。但是：集合对象的内容拷贝仅限于对象本身，对象元素仍然是指针拷贝。
用代码简单表示如下：
```
[immutableObject copy] // 浅拷贝
[immutableObject mutableCopy] //单层深拷贝
[mutableObject copy] //单层深拷贝
[mutableObject mutableCopy] //单层深拷贝
```

### imutable的property 建议使用 copy 来修饰

原因：imutable声明的property的内容有可能是mutable的，此时指向的内容就可能会改变。

```
@interface Person : NSObject 
@property (nonatomic,copy) NSString *name;//这里我们定义为copy
@end


//创建一个可变字符串对象
NSMutableString *mutableString = [[NSMutableString alloc] initWithString:@"hello"];

Person *p = [[Person alloc] init];
[p setName:mutableString];

[mutableString appendString:@" world!"];//更改mutableString的内容

NSLog(@"p.name:%@",p.name);
```

### 参考

- [http://ios.jobbole.com/84581/](http://ios.jobbole.com/84581/)
- [https://www.zybuluo.com/MicroCai/note/50592](https://www.zybuluo.com/MicroCai/note/50592)
