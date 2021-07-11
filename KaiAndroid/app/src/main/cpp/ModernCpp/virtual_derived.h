//
// Created by KaiKai on 2020/11/8.
//

#ifndef TESTDEMO_VIRTUAL_DERIVED_H
#define TESTDEMO_VIRTUAL_DERIVED_H

#include <iostream>

using namespace std;
//基类

class D {
public:
    D() { cout << "D()" << endl; }

    ~D() { cout << "~D()" << endl; }

protected:
    int d;
};

class B : virtual public D {
public:
    B() { cout << "B()" << endl; }

    ~B() { cout << "~B()" << endl; }

protected:
    int b;
};

class A : virtual public D {
public:
    A() { cout << "A()" << endl; }

    ~A() { cout << "~A()" << endl; }

protected:
    int a;
};

class C : public B, public A {
public:
    C() { cout << "C()" << endl; }

    ~C() { cout << "~C()" << endl; }

protected:
    int c;
};

#endif //TESTDEMO_VIRTUAL_DERIVED_H
