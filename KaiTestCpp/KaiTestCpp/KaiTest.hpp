//
//  KaiTest.hpp
//  KaiTestCpp
//
//  Created by KaiKai on 2021/7/11.
//

#ifndef KaiTest_hpp
#define KaiTest_hpp

#include <stdio.h>

class BaseClass {
public:
    //默认可实现：默认构造函数 默认析构函数 复制构造函数 赋值运算符 地址运算符
    // C++11 还有：移动构造函数 移动赋值运算符
    explicit BaseClass(int testValue); //explicit 禁止隐式转换
    BaseClass(const BaseClass &other);
    virtual ~BaseClass();

//    static const int MONTHS = 12;
//    enum TestM {
//        Months = 12
//    };
//    double costs[MONTHS]{};
//    double costs2[Months] = {};

//    void setTestValue(int testValue);

    virtual void printInfoVirtual();
    virtual void printInfoVirtual2();
    void printInfoNoVirtual();

protected:
//    void thisIsProtectedMethod();
//    int mProtectedInt;
private:
    void thisIsPrivateMethod();

//    public:
//        std::ostream &operator<<(std::ostream &os); //成员函数重载<<
//        explicit operator int() const; //转换函数
//        BaseClass &operator=(const BaseClass &other); //重载赋值运算符
//        BaseClass &operator=(int testValue); //进一步重载赋值运算符，避免性能问题（先用int构造临时对象再赋值)
//        bool operator==(const BaseClass &rhs) const;
//        bool operator!=(const BaseClass &rhs) const;
//        bool operator<(const BaseClass &rhs) const;
//        bool operator>(const BaseClass &rhs) const;
//        bool operator<=(const BaseClass &rhs) const;
//        bool operator>=(const BaseClass &rhs) const;
//
//        //如果返回值不加const，那么baseClass + baseClass2 = baseClass4可写但无意义
//        const BaseClass operator+(const BaseClass &r) const;
//
//        char &operator[](int i);

//    protected:
//        friend std::ostream &operator<<(std::ostream &os, const BaseClass &c); //全局函数重载<<
//
//    private:
//        char mCity[40] = "initCity";
        int mTestValue;
        int mTestValue2 = 1; //C++ 11 可直接在此处初始化: 类内初始化 in-class initialization
//        static int sJs;
//        static int sTotalJs;
};

enum class egg { //不加class编译不过，属于相同的作用域
    Small, Media, Large, Jumbo
};
enum class tshirt { //不加class编译不过，属于相同的作用域，限制作用域在类里
    Small, Media, Large, Xlarge
};

class DerivedClass : virtual public BaseClass {
public:
    DerivedClass();
    virtual ~DerivedClass();
    void printInfoVirtual() override;
    void printInfoVirtual2() override;

    //与基类同名同参数函数，将会隐藏基类的函数，即使是指针调用也直接根据指针当前类型调用对应函数，不走虚函数表
    void printInfoNoVirtual(); //正常开发中不要这样使用
};

#endif /* KaiTest_hpp */
