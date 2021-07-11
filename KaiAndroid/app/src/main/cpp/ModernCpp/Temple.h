//
// Created by KaiKai on 2020/11/8.
//

#ifndef TESTDEMO_TEMPLE_H
#define TESTDEMO_TEMPLE_H

#include <iostream>
#include <string>
#include <vector>
#include <cstdlib>
#include <string>
#include <stdexcept>

using namespace std;

template<typename TT>
inline TT const &Max(TT const &a, TT const &b) {
    return a < b ? b : a;
}

template<class T>
class Stack {
private:
    vector<T> elems;     // 元素

public:
    void push(T const &);  // 入栈
    void pop();               // 出栈
    T top() const;            // 返回栈顶元素
    bool empty() const {       // 如果为空则返回真。
        return elems.empty();
    }
};


#endif //TESTDEMO_TEMPLE_H
