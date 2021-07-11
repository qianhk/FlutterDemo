//
// Created by KaiKai on 2020/11/12.
//

#include "ModelCxx.h"
#include <iostream>
#include <utility>

void lambda_value_capture() {
    int value = 1;
    auto copy_value = [value] {
        return value;
    };
    auto copy_value2 = [=] { //隐式捕获 在捕获列表中写一个 & 或 = 向编译器声明采用引用捕获或者值捕获.
        return value;
    };
    value = 100;
    auto stored_value = copy_value();
    std::cout << "值捕获stored_value=" << stored_value << " v2=" << copy_value2() << std::endl;
    // 这时, stored_value == 1, 而 value == 100.
    // 因为 copy_value 在创建时就保存了一份 value 的拷贝
}

void lambda_reference_capture() {
    int value = 1;
    auto copy_value = [&value] {
        return value;
    };
    auto copy_value2 = [&] {
        return value;
    };
    value = 100;
    auto stored_value = copy_value();
    std::cout << "引用捕获stored_value=" << stored_value << " v2=" << copy_value2() << std::endl;
    // 这时, stored_value == 100, value == 100.
    // 因为 copy_value 保存的是引用
}

int main2() {
    [out = std::ref(std::cout << "Result from C code: " << 3)](){
        out.get() << ".\n";
    }();
    auto important = std::make_unique<int>(1);
    auto add = [v1 = 2, v2 = std::move(important)](int x, int y) -> int { //右值捕获
        return x + y + v1 + (*v2);
    };

    std::cout << "表达式捕获:" << add(3, 4) << std::endl;

    auto add14 = [](auto x, auto y) { // c++ 14 允许lambda使用auto
        return x+y;
    };

    add14(1, 2);
    add14(1.1, 2.2);

    return 0;
}

auto addLambda = [](auto x, auto y) {
    return x + y;
};

using foo = void(int); // 定义函数类型, using 的使用见上一节中的别名语法
void functional(foo f) { // 定义在参数列表中的函数类型 foo 被视为退化后的函数指针类型 foo*
    f(1234); // 通过函数指针调用函数
}

int foo2(int para) {
    return para;
}

void modelRuntimeTest() {
    lambda_value_capture();
    lambda_reference_capture();
    main2();
    std::cout << "泛型lambda: " << addLambda(1, 2) << std::endl;
    std::cout << "泛型lambda: " << addLambda(1.1, 2.2) << std::endl;

    auto f = [](int value) {
        std::cout << "空捕获列表当函数指针: " << value + 1 << std::endl;
    };
    functional(f); // 传递闭包对象，隐式转换为 foo* 类型的函数指针值
    f(1); // lambda 表达式调用

    //windows compile error "function": 不是 "std" 的成员
//    // std::function 包装了一个返回值为 int, 参数为 int 的函数
//    std::function<int(int)> func = foo2;
//
//    int important = 10;
//    std::function<int(int)> func2 = [&](int value) -> int {
//        return 1 + value + important;
//    };
////    important = 100;
//    std::cout << "std::function " << func(10) << std::endl;
//    std::cout << "std::function " << func2(10) << std::endl;

}
