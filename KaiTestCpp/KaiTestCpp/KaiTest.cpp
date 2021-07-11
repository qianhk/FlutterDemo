//
//  KaiTest.cpp
//  KaiTestCpp
//
//  Created by KaiKai on 2021/7/11.
//

#include "KaiTest.hpp"


//成员数据被初始化顺序与他们出现在类声明中的顺序相同，与初始化器(成员初始化列表)中的排列顺序无关
BaseClass::BaseClass(int testValue) : /*mTestValue2(2), */ mTestValue(testValue) {
//    ++sJs;
//    ++sTotalJs;
//    std::cout << "BaseClass(int) js=" << sJs << " _value=" << testValue << std::endl;
//    strcpy(mCity, "BaseClass(int)");
}


BaseClass::BaseClass(const BaseClass &other) {
//    ++sJs;
//    ++sTotalJs;
//    std::cout << "CopyConstruct_js=" << sJs << " other.value=" << other.mTestValue << std::endl;
//    strcpy(mCity, "BaseClass(const BaseClass&)");
    mTestValue = other.mTestValue;
}

BaseClass::~BaseClass() {
//    printf("~BaseClass() js=%d totalJs=%d value=%d city=%s\n", sJs, sTotalJs, mTestValue, mCity);
//    --sJs;
}


DerivedClass::DerivedClass() : BaseClass(1010) {
    printf("%s\n", __FUNCTION__);
}

void BaseClass::printInfoVirtual() {
    printf("BaseClass %s\n", __FUNCTION__);
}

void BaseClass::printInfoVirtual2() {
    printf("BaseClass %s\n", __FUNCTION__);
}

void BaseClass::printInfoNoVirtual() {
    printf("BaseClass %s\n", __FUNCTION__);
}

//void BaseClass::thisIsProtectedMethod() {
//    printf("BaseClass::%s\n", __FUNCTION__);
//}

void BaseClass::thisIsPrivateMethod() {
    printf("BaseClass::%s\n", __FUNCTION__);
}

void DerivedClass::printInfoVirtual() {
    printf("DerivedClass %s\n", __FUNCTION__);
}

void DerivedClass::printInfoVirtual2() {
    printf("DerivedClass %s\n", __FUNCTION__);
}

void DerivedClass::printInfoNoVirtual() {
    printf("DerivedClass %s\n", __FUNCTION__);
}

DerivedClass::~DerivedClass() {
    printf("%s\n", __FUNCTION__);
}
