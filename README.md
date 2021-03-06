`iOS` 开发使用总结：

> [iOS_JavaScript](./iOS_JavaScript)

一些关于`iOS`与`JS`交互的经验，解决问题包括：
* `iOS`中如何加载`HTML`页面？（包括`Objective-C`和`Swift`）
* `iOS`中如何去执行一段`JavaScript`代码？（包括`Objective-C`和`Swift`）
* `iOS`中为什么要使用原生语言去执行一段`JavaScript`代码？
* `iOS`中如何监听到`HTML`页面中触发的事件？（`JavaScript`函数的触发）
* `iOS`混合开发中，当`JavaScript`函数触发时，能否发送一些数据给`iOS`原生，如何发送？
* `iOS`混合开发中，当`JavaScript`函数触发时，能否让`OC/Swift`执行一些操作，比如调用系统相机等？

* `JSExport`如何使用？
* 如何使用`JSExport`调用自定义的`OC/Swift`类属性?
* 如何使用`JSExport`调用自定义的`OC/Swift`类的方法？
* 如何使用`JSExport`调用系统或外部引用库的`OC/Swift`类的属性和方法？
* `JSManagedValue`的作用？

具体可参看我的[博客: www.mengyueping.com](http://www.mengyueping.com/categories/iOS/JavaScriptCore/)

> [iOS-keyChain-IDFV](https://github.com/MengYP/apple-stack/tree/master/iOS_KeyChain-IDFV/OC-KeyChain-IDFV)

一些关于`iOS`设备`ID`，与`keychain`存储经验，解决问题包括：
* `UDID`、`MAC地址`、`UUID`、`IDFV`、`keychain`、`IDFA`能作为设备的唯一标识吗？
* 如何使用`IDFV`和`keychain`来标识安装`App`的设备？
* 如何来标识本公司所有`App`安装的设备？记录用户应用使用习惯？
* 用哪种`ID`追踪某一台设备是否在下载过某个应用?

具体可参看我的[博客: www.mengyueping.com](http://www.mengyueping.com/2017/07/12/iOS-keyChain-IDFV/)

> [iOS-runtime-archive](https://github.com/MengYP/apple-stack/tree/master/iOS_runtime-archive)

使用`runtime`进行归档解档：
* 不使用`runtime`情况下，**归档/解档**有什么缺点？
* 如何使用`runtime`进行**归档/解档**？
* 使用`runtime`进行**归档/解档**好处是什么？

具体可参看我的[博客: www.mengyueping.com](http://www.mengyueping.com/2017/07/17/iOS-runtime-archive/)

> [iOS-runtime-methodExchange](https://github.com/MengYP/apple-stack/tree/master/iOS_runtime-methodExchange)

使用Runtime对系统方法实现方法交换
* 如何对系统方法进行添加功能，在不修改原有方法调用的基础之上？
* 项目中已经大量使用了字符串转`URL`的调用，调用的系统方法，而没有对字符串进行转码，这样如果字符串中出现中文的话会导致`URL`转换失败的情况，那么如何不大量修改原项目中代码，来实现对`URL`的转码以及判空？

具体可参看我的[博客: www.mengyueping.com](http://www.mengyueping.com/2017/07/18/iOS-runtime-methodExchange/)

>- [iOS_Swift](./iOS_Swift)

### [1.`Swift`中的一些基本语法使用 (Swift 3)](https://github.com/MengYP/apple-stack/tree/master/iOS_Swift/01-Swift%E8%AF%AD%E6%B3%95%E7%AC%94%E8%AE%B0)

* 01-常量与变量
* 02-数值类型
* 03-布尔类型
* 04-元组
* 05-可选类型
* 06-错误处理
* 07-断言
* 08-基本运算符
* 09-字符串和字符
* 10-集合类型
* 11-控制流
* 12-函数
* 13-闭包
* 14-枚举
* 15-类和结构体
* 16-属性
* 17-方法
* 18-下标
* 19-继承
* 20-构造过程

### [2.`Swift`尝试](https://github.com/MengYP/apple-stack/tree/master/iOS_Swift/02-Swift%E5%B0%9D%E8%AF%95)

从`OC`到`Swift`，`Cocoa Touch`使用。

* [01-基础](https://github.com/MengYP/apple-stack/tree/master/iOS_Swift/02-Swift%E5%B0%9D%E8%AF%95/01-%E5%9F%BA%E7%A1%80)
    >- 01-基础 
    >- 02-构造函数
    >- 03-tableView
    >- 04-closure
    
* [02-微博 (小试牛刀，不断更新中...)](https://github.com/MengYP/apple-stack/tree/master/iOS_Swift/02-Swift%E5%B0%9D%E8%AF%95/02-Weibo)

* [03-编程训练](https://github.com/MengYP/apple-stack/tree/master/iOS_Swift/02-Swift%E5%B0%9D%E8%AF%95/03-%E7%BC%96%E7%A8%8B%E8%AE%AD%E7%BB%83)
    >- 01-Fibonacci数列
    >- 02-求质数
    >- 03-求水仙花数
    >- 04-统计字符串中各类字符个数
    >- 05-给定项数的数字的和
    >- 06-自由落体反弹问题
    >- 07-求无重复的三位数
    >- 08-求完全平方数
    >- 09-求一年中的第几天
    >- 10-猴子吃桃问题
    >- 11-求分数数列的和
    >- 12-求1-n的阶乘的和
    >- 13-倒推年龄
    >- 14-倒序打印一个正整数
    >- 15-回文问题
    >- 16-求5x5矩阵对角线之和
    >- 17-折半查找
    >- 18-围圈报数
    >- 19-猴子分桃问题
    >- 20-数字加密问题

* [04-表情键盘](https://github.com/MengYP/apple-stack/tree/master/iOS_Swift/02-Swift%E5%B0%9D%E8%AF%95/04-%E8%A1%A8%E6%83%85%E9%94%AE%E7%9B%98)
    > 一个表情键盘的封装

