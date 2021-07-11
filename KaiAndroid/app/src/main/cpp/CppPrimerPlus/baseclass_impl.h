#ifndef CPPPRACTICE_BASECLASS_IMPL_H
#define CPPPRACTICE_BASECLASS_IMPL_H

#include "baseclass.h"
#include "iostream"

using std::cout;
using std::endl;

namespace kaicpp {
    template<typename T>
    void kaiswap(T &a, T &b) {
        printf("kaiswap common template version a=%d b=%d\n", (int)a, (int)b);
        T temp = a;
        a = b;
        b = temp;
    }

    template<typename T1, typename T2>
    void ft(T1 x, T2 y) {
        decltype(x + y) xpy = x + y;
        cout << "x=" << x << " y=" << y << " result=" << xpy << endl;
    }

}
#endif
