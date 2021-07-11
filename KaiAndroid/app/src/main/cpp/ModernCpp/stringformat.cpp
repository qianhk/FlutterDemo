//
// Created by kai on 2021/6/4.
//

#include "stringformat.h"
#include <string>
#include <iostream>
//#include <format> //c++20

//before c++ 11
std::string format_vsnprintf(const char *fmt, ...) {
    va_list args;
    va_start(args, fmt);
    const auto len = vsnprintf(nullptr, 0, fmt, args);
    va_end(args);
    std::string r;
    r.resize(static_cast<size_t>(len) + 1);
    va_start(args, fmt);
    vsnprintf(&r.front(), len + 1, fmt, args);
    va_end(args);
    r.resize(static_cast<size_t>(len));
    return r;
}

//>= c++ 11
template<class... T>
std::string format_snprintf(const char *fmt, const T &...t) {
    const auto len = snprintf(nullptr, 0, fmt, t...);
    std::string r;
    r.resize(static_cast<size_t>(len) + 1);
    snprintf(&r.front(), len + 1, fmt, t...);  // Bad boy
    r.resize(static_cast<size_t>(len));
    return r;
}

void stringFormatMain() {
    std::cout << "------ test string format --------\n";
    int i = 3;
    double d = 6.7;
    const char *cs = "cs";
    std::string ss = "ss";
    const std::string &tmpString1 = format_vsnprintf("i=%d, d=%-6.2f, cs=%s, ss=%s\n", i, d, cs, ss.c_str());
    std::cout << "format_vsnprintf: " << tmpString1;

    const std::string &tmpString2 = format_snprintf("i=%d, d=%-6.2f, cs=%s, ss=%s\n", i, d, cs, ss.c_str());
    std::cout << "format_snprintf: " << tmpString2;

//    std::stringstream oss;
//    oss << "i=" << i
//        << ", d=" << std::left << std::setw(6) << std::fixed << std::setprecision(2) << d
//        << ", cs=" << cs
//        << ", ss=" << ss;

// c++20
//    std::format("i={}, d={:<6.2f}, cs={}, ss={}", i, d, cs, ss);
//    std::format("i({0}) == i({0})", i);
}
