//
// Created by KaiKai on 2021/5/9.
//

#include "exceptiondemo.h"
#include <iostream>
#include <cstdlib>
#include <exception>

//double hmean_abort(double a, double b) throw(xxx) 可能抛出xxx异常; throw() 不会抛出异常
// c++ 11 抛弃了这种异常规范的用法，后续可能从标准中剔除，因为编译器难以判断函数内容是否真的匹配这种异常规范的声明
//double hmean_abort(double a, double b) noexcept; //C++ 11 新增这种用法表示不会抛出异常，但普通代码仍然不推荐使用

double hmean_abort(double a, double b) {
    if (a == -b) {
        std::cout << "untenable argument to hmean(): std::abort()\n";
//        std::abort();
    }
    return 2.0 * a * b / (a + b);
}

double hmean_throw_const_char_string(double a, double b) {
    if (a == -b) {
        const char *exString = "untenable argument to hmean(): hmean_throw_const_char_string";
        std::cout << "throw exception const char *: " << (void *) exString << std::endl;
        throw exString;
    }
    return 2.0 * a * b / (a + b);
}

class bad_hmean {
private:
    double v1, v2;
public:
    explicit bad_hmean(double a = 0, double b = 0) : v1(a), v2(b) {};
    void mesg() const;
};

inline void bad_hmean::mesg() const {
    std::cout << "bad_hmean_mesg: (" << v1 << ", " << v2 << "): invalid argument a == -b.\n";
}


double hmean_throw_bad_hmean(double a, double b) {
    if (a == -b) {
        const bad_hmean &hmean = bad_hmean(a, b);
        std::cout << "throw exception bad_hmean: " << &hmean << std::endl;
        throw hmean;
    }
    return 2.0 * a * b / (a + b);
}

class bad_hmean2 : public std::exception {
private:
    double v1, v2;
    char whatstr[64];
public:
    explicit bad_hmean2(double a = 0, double b = 0) : v1(a), v2(b), whatstr{} {
        sprintf(whatstr, R"(bad_hmean2_mesg: (%.4f, %.4f) : invalid argument a == -b)", a, b);
    };

    const char *what() const noexcept override {
        return whatstr;
    }
};

double hmean_throw_bad_hmean2(double a, double b) {
    if (a == -b) {
//        const bad_hmean2 &hmean = bad_hmean2(a, b);
//        std::cout << "throw exception bad_hmean2: " << &hmean << std::endl;
//        throw hmean;
        throw bad_hmean2(a, b);
    }
    return 2.0 * a * b / (a + b);
}

////error: ISO C++17 does not allow dynamic exception specifications
//double hmean_throw_bad_hmean3(double a, double b) throw(int) {
//    if (a == -b) {
//        throw bad_hmean2(a, b);
//    }
//    return 2.0 * a * b / (a + b);
//}

void myQuit() {
    std::cout << "myQuit, Terminating due to uncaugh exception.\n";
}

void myUnexpected() {
    std::cout << "myUnexpected\n";
}

struct Big {
    double stuff[20000];
};

void exceptionTestMain() {

    std::set_terminate(myQuit);
//    std::set_unexpected(myUnexpected); // //c++17 error: no type named 'set_unexpected' in namespace 'std'

    double x, y, z;
    x = 3, y = 6;
    z = hmean_abort(x, y);
    z = hmean_abort(10, -10);

    z = hmean_throw_const_char_string(x, y);
    try {
        z = hmean_throw_const_char_string(10, -10);
    } catch (const char *s) { //指针地址相同，未浅复制
        std::cout << "catch hmean_throw_const_char_string: " << s << " address=" << (void *) s << std::endl;
    }

    try {
        z = hmean_throw_bad_hmean(10, -10);
    } catch (const bad_hmean &bg) { //对象会浅复制，即便使用引用；此处依然推荐使用引用，因为当函数是虚函数时，可通过基类执行派生类重写的函数
        bg.mesg();
        std::cout << "catch bad_hmean address=" << &bg << std::endl;
    }

    try {
        z = hmean_throw_bad_hmean2(10, -10);
    } catch (const bad_hmean2 &bg) { //对象会浅复制
        std::cout << "catch bad_hmean2 address=" << &bg << " " << bg.what() << std::endl;
    }

    try {
//        z = hmean_throw_bad_hmean2(10, -10);
    } catch (std::logic_error &logic_error) {
        //不会捕获到这个异常
        std::cout << "no catch : logic_error\n";
    } catch (std::runtime_error &runtime_error) {
        //不会捕获到这个异常
        std::cout << "no catch : runtime_error\n";
    }
    // 会走到std::set_terminate 设置的 myQuit ，但并不能阻止terminate
    // mac os 系统输出：libc++abi: terminate_handler unexpectedly returned

    try {
        z = hmean_throw_bad_hmean2(10, -10);
    } catch (...) {
        //捕获所有类型异常，但应该不见得真的各种各样的异常都能捕获到
        std::cout << "catch ... \n";
    }

//    z = hmean_throw_bad_hmean3(10, -10);
    // 声明抛出int异常，但是抛出的是其它unexpected异常，触发std::set_unexpected 设置的 myUnexpected
    // 然后继续crash, mac os 系统输出 libc++abi: unexpected_handler unexpectedly returned

    Big *pb = nullptr;
    try {
    pb = new Big[10]; // 8 * 20000 * 10 = 1,600,000
//    pb = new Big[100]; // 8 * 20000 * 100 = 16,000,000
//        pb = new Big[10000000]; //sizeof(double) * 20000 * 10000000 = 1,600,000,000,000
        // macos new 1.6T 内存 会正常返回地址， 相反编译的时候卡了3秒左右，可能在做什么优化吧
        // win msvc 会crash
    } catch (const std::bad_alloc & e) {
        std::cout << "new big exception: std::bad_alloc, what=" << e.what() << std::endl;
    }

//    pb = new(std::nothrow) Big[10000000]; //win msvc 加了std::nothrow返回 NULL

    Big &&big = Big();
    big.stuff[0] = 1;
    big.stuff[1] = 2;
//    pb[1000000 - 2] = big;
    std::cout << "new big address=" << (void *) pb << " sizeofByte=" << sizeof(*pb) << std::endl;

    int *pi = new(std::nothrow) int; //new失败时 不要抛出 bad_alloc异常 而是返回空指针
    int *pi2 = new(std::nothrow) int[100]; //貌似用于指针
}

