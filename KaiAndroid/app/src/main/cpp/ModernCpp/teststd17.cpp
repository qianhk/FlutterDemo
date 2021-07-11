//
// Created by kai on 2021/5/25.
//

#include "teststd17.h"

#include <iostream>
#include <optional>
#include <any>
#include <string>
#include <string_view>

using namespace std;

struct Out {
    string out1;
    string out2;
};

optional<Out> func(const string &in) {
    Out o;
    if (in.empty())
        return nullopt;
    o.out1 = "hello";
    o.out2 = "world";
    return {o};
}

void foo() { std::cout << "hello world\n"; };

void testStd17Main() {
    std::cout << "------ test std17 Main --------\n";

    {
        auto ret = func("");
        cout << "func\"\": has_value=" << ret.has_value() << endl;
    }

    if (auto ret = func("hi"); ret.has_value()) {
        cout << "func\"hi\": " << ret->out1 << " " << ret->out2 << endl;
    }

    std::any a = 1;
    std::cout << a.type().name() << ": " << std::any_cast<int>(a) << '\n';
    a = 3.14;
    std::cout << a.type().name() << ": " << std::any_cast<double>(a) << '\n';
    a = true;
    std::cout << a.type().name() << ": " << std::any_cast<bool>(a) << '\n';

    std::any b = 4.3; // b has value 4.3 of type double

    a = 42; // a has value 42 of type int
    b = std::string{"hi"}; // b has value "hi" of type std::string

    if (a.type() == typeid(std::string)) {
        std::string &&s = std::any_cast<std::string>(a);
//        useString(s);
    } else if (a.type() == typeid(int)) {
//        useInt(std::any_cast<int>(a));
    }
    //如果转换失败，因为对象为空或包含的类型不匹配，则抛出std::bad_any_cast
    //还可以为std::any对象的地址调用std::any_cast。在这种情况下，如果类型匹配，则强制转换返回相应的地址指针;如果不匹配，则返回nullptr:
    auto p = std::any_cast<std::string>(&a);
    if (p) {

    }

    char arr[]{"Gold"};
    std::string_view str{arr};    //wstring_view
    std::cout << str << '\n'; // Gold
    // Change 'd' to 'f' in arr
    arr[3] = 'f';
    std::cout << str << '\n'; // Golf

//    using namespace std::literals;

    std::string_view s1 = "abc\0\0def";
    std::string_view s2 = "abc\0\0def"sv;
    std::cout << "s1: " << s1.size() << " \"" << s1 << "\"\n";
    std::cout << "s2: " << s2.size() << " \"" << s2 << "\"\n";

    {
        //https://theonegis.github.io/cxx/C-17%E4%BD%BF%E7%94%A8std-apply%E5%92%8Cfold-expression%E5%AF%B9tuple%E8%BF%9B%E8%A1%8C%E9%81%8D%E5%8E%86/
        // 两个元素相加
        std::cout << std::apply([](auto x, auto y) { return x + y; },
                                std::make_tuple(1, 2.0)) << '\n';

        // 多个元素相加，使用parameter pack
        std::cout << std::apply([](auto &&... args) { return (args + ...); },
                                std::make_tuple(1, 2.f, 3.0)) << '\n';
        // 遍历tuple并输出，注意逗号操作符的使用 如果在C++17之前想要遍历tuple就比较麻烦，需要很多额外的操作
        std::apply([](auto &&... args) { ((std::cout << args << '_'), ...); },
                   std::make_tuple(1, 2.f, 3.0));
        std::cout << std::endl;
    }

    auto c = [](int a) { std::cout << "hi from lambda:" << a << "\n"; };
    std::invoke(foo);
    std::invoke(c, 321);
}
