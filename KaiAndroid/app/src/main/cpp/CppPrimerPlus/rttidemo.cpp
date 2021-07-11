//
// Created by KaiKai on 2021/5/9.
//

#include "rttidemo.h"
#include "baseclass.h"

using namespace kaicpp;

void rttiDemoMain() {
    BaseClass baseClass = BaseClass(3000);
    DerivedClass derivedClass = DerivedClass();
    BaseClass *pBase = &baseClass;
    DerivedClass *pDerived = &derivedClass;
    pBase = pDerived;
    pDerived = dynamic_cast<DerivedClass *>(pBase); // ok
    pBase = &baseClass;
    pDerived = dynamic_cast<DerivedClass *>(pBase); // return 0
//    pDerived->printInfoVirtual(); //空指针 EXC_BAD_ACCESS (code=1, address=0x0)
    RTTIDemo rttiDemo;
    RTTIDemo *pRttiDemo = &rttiDemo;

    //无继承关系，转出来的指针不为null，直接等于pRttiDemo, 二进制重新解释，含义由程序员代码自行决定
    pBase = reinterpret_cast<BaseClass *>(pRttiDemo);
//    pBase->printInfoVirtual(); //EXC_BAD_ACCESS (code=EXC_I386_GPFLT) 野指针

    const std::type_info &info0 = typeid(pRttiDemo);
    const std::type_info &info1 = typeid(pBase); //0x0000000100f404e0
    pBase = &baseClass; //指向相同类的type_info是同一个实例
    const std::type_info &info2 = typeid(pBase); //0x0000000100f404e0
    const std::type_info &info2_2 = typeid(*pBase); //pBase 和 *pBase是不同的type_info
    const std::type_info &info2_3 = typeid(baseClass); //info2_2与info2_3地址相同
    pBase = &derivedClass;
    const std::type_info &info3 = typeid(pBase); //0x0000000100f404e0
    pDerived = &derivedClass;
    const std::type_info &info4 = typeid(pDerived); //0x0000000100f40500
    bool boolResult = info1 == info2;
    boolResult = info2 == info4;
    boolResult = info2 == info2_2;
    //mac os: info rttiDemo=P8RTTIDemo pBase=PN6kaicpp9BaseClassE base=N6kaicpp9BaseClassE derived=PN6kaicpp12DerivedClassE~DerivedClass
    //mac os : 没有虚函数的类也能得到name，但都不是原始类名，name的值取决于编译器实现 指针name前面多了个P
    //mscv2017 info rttiDemo=class RTTIDemo * __ptr64 pBase=class kaicpp::BaseClass * __ptr64 base=class kaicpp::BaseClass
    //         derived=class kaicpp::DerivedClass * __ptr64kaicpp::DerivedClass::~DerivedClass
    printf("info rttiDemo=%s pBase=%s base=%s derived=%s", info0.name(), info2.name(), info2_2.name(), info4.name());
}

void RTTIDemo::doSth() {
    printf("RTTIDemo::doSth()\n");
}
