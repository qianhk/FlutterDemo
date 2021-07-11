#include <cstdio>
#include <climits>
#include <cctype>
#include <iostream>
#include <vector>
#include <array>
#include <ctime>
#include "baseclass.h"
#include <valarray>
#include "templateclass.hpp"
#include "exceptiondemo.h"
#include "rttidemo.h"
#include "stltest.h"

extern int gTestValue;
//extern const int gTestConstValue2;
namespace kaicppsub2 = kaicpp::subns::subns2;
using std::endl;

//模板别名 C++ 11
template<typename T>
using Stack_3 = kaicpp::Stack<T, 3>;

template<int n>
using IntStack = kaicpp::Stack<int, n>;

//typedef 无法用在模板别名上
//typedef template <typename T> kaicpp::Stack<T, 3> xxxx;

int mainEntry() {

#if defined(KAI_DLL_EXPORTS)
    std::cout << "in exe: defined KAI_DLL_EXPORTS\n";
#else
    std::cout << "in exe: not defined KAI_DLL_EXPORTS\n";
#endif

    printf(R"(raw ansi string \"\n")");
    printf(R"Kai(   self has )")Kai");
    std::cout << std::endl;
    wprintf(LR"(raw wide string \"\n")");
    wprintf(LR"Kai(   self has )")Kai");
    std::wcout << std::endl;

    float d = 4321.123456789f;
    std::cout << std::fixed;
    std::cout.precision(2);
    std::cout.setf(std::ios_base::showpoint);
    std::cout << "float d=" << d << R"(    "extern int gTestValue"=)" << gTestValue;
    std::cout << std::endl;

    std::vector<int> vi{6, 7};
    vi.push_back(10);
//    vi.at(0) = 16;
    for (auto &&item : vi) { //为什么在使用循环语句的过程中，auto&& 是最安全的方式？ 因为当 auto 被推导为不同的左右引用时，与 && 的坍缩组合是完美转发。
        //https://github.com/changkun/modern-cpp-tutorial/blob/master/book/zh-cn/03-runtime.md
        std::cout << item << ' ';
    }
    std::cout << std::endl;

    std::array<int, 10> ai{1, 3, 4};
    ai[1] = 2;
    ai[6] = 7;
    ai.at(7) = 8;
    for (auto &item : ai) {
        ++item;
    }
    for (const auto &item : ai) {
        std::cout << item << ' ';
    }
    std::cout << std::endl;

    printf("clock per sec: %d\n", CLOCKS_PER_SEC);
    clock_t delay = 0.1 * CLOCKS_PER_SEC;
    clock_t start = clock();
    while (clock() - start < delay) {
        --delay, ++delay;
    }
    std::cout << "after clock\n";

    outputTestConstValueInfo();
    printf("&gTestValue in Main: %p\n", &gTestValue);
    printf("&gTestConstValue in Main: %p\n", &gTestConstValue);
    printf("&gTestConstValue2 in Main: %p\n", &gTestConstValue2);

    int ia = 1, ib = 2, ic = 3, id = 4, ie = kaicpp::subns::subns2::innerValue, ig = kaicppsub2::innerValue;
    float fa = 10.1, fb = 20.2;
    kaicpp::kaiswap(ia, ib);
    kaicpp::kaiswap(fa, fb);
    kaicpp::kaiswap(ic, id);
    printf("ia=%d ib=%d fa=%.1f fb=%.1f ic=%d id=%d\n", ia, ib, fa, fb, ic, id);
    kaicpp::ft(ia, fa);
    float result = kaicpp::testAutoResult(ie, fa);
    result = kaicpp::testAutoResult(ig, fa);
    int noNeedInt = kaicpp::MONTHS;
    noNeedInt = kaicpp::ENum2;
    noNeedInt = kaicpp::TestEnum::Enum1;

    kaicpp::BaseClass baseClass(10);
    noNeedInt = baseClass.Months;
    noNeedInt = kaicpp::BaseClass::MONTHS;
    noNeedInt = kaicpp::BaseClass::TestM::Months;

    baseClass.costs;
    noNeedInt = int(kaicpp::egg::Media); //类作用域内的枚举不能隐式转换
    noNeedInt = static_cast<int>(kaicpp::tshirt::Large);
//    kaicpp::BaseClass baseClass2 = 10;// 构造函数加了explicit后必须显示转换
    std::cout << baseClass << endl;
    baseClass << std::cout << endl;
    noNeedInt = static_cast<int>(baseClass);
    kaicpp::BaseClass baseClass2(baseClass);
    kaicpp::BaseClass baseClass3 = baseClass; //有可能是复制构造后再赋值，取决于编译器的实现
    baseClass3.setTestValue(42);
    baseClass2 = baseClass3;
    char &c = baseClass2[3];
    baseClass3 = 82;
    baseClass3 = baseClass3;
    std::cout << "----------------1-------------\n";
    kaicpp::BaseClass baseClass4 = baseClass + baseClass2;
    std::cout << "----------------2-------------\n";
    baseClass4 = baseClass + baseClass3;
    std::cout << "----------------3-------------\n";
//    baseClass + baseClass2 = baseClass4;
    std::cout << "----------------class-------------\n";
    baseClass.printInfoVirtual();
    baseClass.printInfoNoVirtual();
    kaicpp::DerivedClass derivedClass;
    derivedClass.printInfoVirtual();
    derivedClass.printInfoNoVirtual();
    std::cout << "----------------pointer normal------------\n";
    kaicpp::BaseClass *pBaseClass = &baseClass;
    kaicpp::DerivedClass *pDerivedClass = &derivedClass;
    pBaseClass->printInfoVirtual();
    pBaseClass->printInfoNoVirtual();
    pDerivedClass->printInfoVirtual();
    pDerivedClass->printInfoNoVirtual();
    std::cout << "----------------pointer derived -> error ------------\n";

    // 虚继承时直接禁止(编译错误) cannot cast xx to xx via virtual base
//    pDerivedClass = (kaicpp::DerivedClass *) pBaseClass; //正常开发中禁止这样使用
//    pDerivedClass->printInfoVirtual(); //BaseClass printInfoVirtual
//    pDerivedClass->printInfoNoVirtual(); //此错误示例把base强制转给了derived， DerivedClass printInfoNoVirtual
    std::cout << "----------------pointer base -> derived ------------\n";
    pBaseClass = &derivedClass;
    pBaseClass->printInfoVirtual(); //DerivedClass printInfoVirtual
    pBaseClass->printInfoNoVirtual(); //BaseClass printInfoNoVirtual
    std::cout << "----------------pointer base -> ref ------------\n";
    kaicpp::BaseClass &refBaseClass = derivedClass;
    refBaseClass.printInfoVirtual(); //DerivedClass printInfoVirtual
    refBaseClass.printInfoNoVirtual(); //BaseClass printInfoVirtual

    std::cout << "---------------- valarray ------------\n";
    std::valarray<int> v(66, 8);
    noNeedInt = v.min();
    noNeedInt = v.max();
    noNeedInt = v.size();
    noNeedInt = v.sum();
    std::cout << "---------------- private inherit ------------\n";
    kaicpp::DerivedPrivateClass derivedPrivateClass;
    derivedPrivateClass.printInfoVirtual();
    derivedPrivateClass.thisIsProtectedMethod();
//    derivedPrivateClass.thisIsPrivateMethod(); //原私有方法不能通过using重新定义访问权限

    //cannot cast 'kaicpp::DerivedPrivateClass' to its private base class 'kaicpp::BaseClass'
//    pBaseClass = &derivedPrivateClass;

    std::cout << "---------------- class virtual public otherClass ------------\n";
    kaicpp::SecondDerivedClass secondDerivedClass;
//    secondDerivedClass.printInfoVirtual(); //多继承调用的哪个基类的方法？ xxx found in multiple base classes of different types
    secondDerivedClass.DerivedClass::printInfoVirtual(); //或者在secondDerivedClass里override一个printInfoVirtual
    secondDerivedClass.DerivedPrivateClass::printInfoVirtual();
    secondDerivedClass.BaseClass::printInfoVirtual2();
    secondDerivedClass.DerivedClass::printInfoVirtual2();
    secondDerivedClass.DerivedPrivateClass::printInfoVirtual2();
    secondDerivedClass.printInfoVirtual2();
    std::cout << "---------------- template class ------------\n";
    kaicpp::Stack<int, 3> kaiStack;
    bool noNeedBool = kaiStack.isEmpty();
    noNeedBool = kaiStack.push(1);
    noNeedBool = kaiStack.push(2);
    noNeedBool = kaiStack.push(3);
    noNeedBool = kaiStack.push(4);
    noNeedBool = kaiStack.pop(noNeedInt);
    noNeedBool = kaiStack.isEmpty();
    noNeedBool = kaiStack.pop(noNeedInt);
    noNeedBool = kaiStack.pop(noNeedInt);
    noNeedBool = kaiStack.pop(noNeedInt);
    std::cout << "---------------- 成员模板 ------------\n";
    kaicpp::beta<double> guy(3.5, 3);
    guy.show();
    std::cout << guy.blab(10, 2.3) << endl;
    std::cout << guy.blab(10.0, 2.3) << endl;
    guy.show2();
    std::cout << guy.blab2(10, 2.3) << endl;
    std::cout << guy.blab2(10.0, 2.3) << endl;
    std::cout << "---------------- templates as parameters ------------\n";
    kaicpp::Crab<kaicpp::Stack, int, float, 2> nebula;
    nebula.push(1, 1.1);
    nebula.push(2, 2.2);
    nebula.push(3, 3.3);
    nebula.pop(noNeedInt, fa);
    nebula.pop(noNeedInt, fa);
    nebula.pop(noNeedInt, fa);
    std::cout << "---------------- 模板类和友元 unbound template friend to a template class ------------\n";
    typedef kaicpp::ManyFriend<int> IntManyFriend;
    using DoubleManyFriend = kaicpp::ManyFriend<double>; //C++ 11: 使用using 代替 typedef
    using USING_INT = int;
//    using p1 = const char *;
//    typedef const int *(*pa1)[10];
//    using pa2 = const int *(*)[10]; //可读性更好

    kaicpp::ManyFriend<USING_INT> hfi1(10);
    IntManyFriend hfi2(20);
    DoubleManyFriend hfdb(10.5);
    showTemplate(hfi1, hfi2);
    showTemplate(hfdb, hfi2);

    IntStack<2> intStackTest;
    Stack_3<double> doubleStack;

    std::cout << "---------------- friend class ------------\n";
    kaicpp::TV tv{};
    kaicpp::Remote remote;
    remote.set_chan(tv, 10);

    std::cout << "---------------- exception test ------------\n";
    exceptionTestMain();
    std::cout << "---------------- RTTI (Runtime Type Identification) 运行阶段类型识别 只对有虚函数的类起作用 ------------\n";
    rttiDemoMain();
    std::cout << "---------------- stl ------------\n";
    stlTestMain();
    std::cout << "---------------- over ------------\n";
    return 0;
}

/*


 */

