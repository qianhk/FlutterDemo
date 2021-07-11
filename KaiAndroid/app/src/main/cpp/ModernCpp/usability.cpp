//
//

#include "usability.h"
#include <iostream>
#include <vector>
#include <tuple>
#include <string>
//#include <variant> // c++ 17
#include <initializer_list>
#include <vector>

#define LEN 10

class InitializerListTest {
public:
    std::vector<int> vec;

    InitializerListTest(std::initializer_list<int> list) {
        for (auto &&it = list.begin(); it != list.end(); ++it) {
            vec.push_back(*it);
        }
    }

public:
    void foo(std::initializer_list<int> list) {
        for (int it : list) {
            vec.push_back(it);
        }
    }
};

int len_foo() {
    int i = 2;
    return i;
}

constexpr int len_foo_constexpr() {
    return 5;
}

constexpr int fibonacci(const int n) {
    return n == 1 || n == 2 ? 1 : fibonacci(n - 1) + fibonacci(n - 2);
}

std::tuple<int, double, std::string> makeTestTuple() {
    return std::make_tuple(1, 2.3, "456");
}

auto get_student(int id) {
    // 返回类型被推断为 std::tuple<double, char, std::string>

    if (id == 0)
        return std::make_tuple(3.8, 'A', "张三");
    if (id == 1)
        return std::make_tuple(2.9, 'C', "李四");
    if (id == 2)
        return std::make_tuple(1.7, 'D', "王五");
    return std::make_tuple(0.0, 'D', "null");
    // 如果只写 0 会出现推断错误, 编译失败
}
//c++17 std::variant
//template <size_t n, typename... T>
//constexpr std::variant<T...> _tuple_index(const std::tuple<T...>& tpl, size_t i) {
//    if constexpr (n >= sizeof...(T))
//        throw std::out_of_range("越界.");
//    if (i == n)
//        return std::variant<T...>{ std::in_place_index<n>, std::get<n>(tpl) };
//    return _tuple_index<(n < sizeof...(T)-1 ? n+1 : 0)>(tpl, i);
//}
//template <typename... T>
//constexpr std::variant<T...> tuple_index(const std::tuple<T...>& tpl, size_t i) {
//    return _tuple_index<0>(tpl, i);
//}
//template <typename T0, typename ... Ts>
//std::ostream & operator<< (std::ostream & s, std::variant<T0, Ts...> const & v) {
//    std::visit([&](auto && x){ s << x;}, v);
//    return s;
//}

template<typename T>
auto tuple_len(T &tpl) {
    return std::tuple_size<T>::value;
}

void usabilityMain() {
    if (std::is_same<decltype(NULL), decltype(0)>::value)  //always false
        std::cout << "NULL == 0" << std::endl;
    if (std::is_same<decltype(NULL), decltype((void *) 0)>::value)  //always false
        std::cout << "NULL == (void *)0" << std::endl;
    if (std::is_same<decltype(NULL), std::nullptr_t>::value)  //always false
        std::cout << "NULL == nullptr" << std::endl;
    if (std::is_same<decltype(NULL), decltype(NULL)>::value)  //always true
        std::cout << "NULL == NULL" << std::endl;

    char arr_1[10];                      // 合法
    char arr_2[LEN];                     // 合法

    int len = 10;
    // 注意，现在大部分编译器其实都带有自身编译优化，很多非法行为在编译器优化的加持下会变得合法，若需重现编译报错的现象需要使用老版本的编译器。
    // clang++ -v Apple clang version 11.0.0 是能正常运行的
//    int arr_3[len];                  // 非法
//    arr_3[1] = 100;

    const int len_2 = len + 1;
    constexpr int len_2_constexpr = 1 + 2 + 3;
//    char arr_4[len_2];                // 非法  msvc : error C2131: expression did not evaluate to a constant
    char arr_4_2[len_2_constexpr];         // 合法

    // char arr_5[len_foo()+5];          // 非法
    char arr_6[len_foo_constexpr() + 1]; // 合法

    std::cout << fibonacci(10) << std::endl;
    // 1, 1, 2, 3, 5, 8, 13, 21, 34, 55
    std::cout << fibonacci(10) << std::endl;

    std::vector<int> vec = {1, 2, 3, 4};

    // 在 c++17 之前
    const std::vector<int>::iterator itr1 = std::find(vec.begin(), vec.end(), 2);
    if (itr1 != vec.end()) {
        *itr1 = 3;
    }

    // 需要重新定义一个新的变量
    const std::vector<int>::iterator itr2 = std::find(vec.begin(), vec.end(), 3);
    if (itr2 != vec.end()) {
        *itr2 = 4;
    }

    //c++ 17  if 里可定义局部变量名
    if (const std::vector<int>::iterator itr = std::find(vec.begin(), vec.end(), 3);
            itr != vec.end()) {
        *itr = 4;
    }

    auto[x, y, z] = makeTestTuple(); //std::make_tuple c++ 11 但自动解包c++ 17
    std::cout << "std::make_tuple: " << x << ", " << y << ", " << z << std::endl;

    auto student = get_student(0);
    std::cout << "ID: 0, "
              << "GPA: " << std::get<0>(student) << ", "
              << "成绩: " << std::get<1>(student) << ", "
              << "姓名: " << std::get<2>(student) << '\n';

    auto xxx = makeTestTuple();
    std::cout << "testTuple, "
              << "0: " << std::get<0>(xxx) << ", "
              << "1: " << std::get<1>(xxx) << ", "
              << "2: " << std::get<2>(xxx) << '\n';

    std::tuple<double, double, int, std::string> t(4.5, 6.7, 8, "v123");
    std::cout << std::get<std::string>(t) << std::endl;
//    std::cout << std::get<double>(t) << std::endl; // 非法, 引发编译期错误
    std::cout << std::get<3>(t) << std::endl;

    int index = 1;
//    std::get<index>(t); //error: no matching function for call to 'get'  std::get<> 依赖一个编译期的常量
//    std::cout << tuple_index(t, i) << std::endl; //c++ 17 std::variant

    auto new_tuple = std::tuple_cat(get_student(1), t);
    std::cout << "new_tuple len: " << tuple_len(new_tuple) << std::endl;
//    auto new_tuple = std::tuple_cat(get_student(1), std::move(t));

    double gpa;
    char grade;
    std::string name;

    // 元组进行拆包
    std::tie(gpa, grade, name) = get_student(1);
    std::cout << "ID: 1, "
              << "GPA: " << gpa << ", "
              << "成绩: " << grade << ", "
              << "姓名: " << name << '\n';

    if (std::is_same<decltype(x), int>::value)
        std::cout << "type x == int" << std::endl;
    if (std::is_same<decltype(x), float>::value)
        std::cout << "type x == float" << std::endl;
    if (std::is_same<decltype(x), decltype(z)>::value)
        std::cout << "type z == type x" << std::endl;

    InitializerListTest initializerListTest = {1, 2, 3, 4, 5};
    std::cout << "initializerListTest before: ";
    for (int &it : initializerListTest.vec) {
        std::cout << it << " ";
    }
    std::cout << "\ninitializerListTest after: ";
    initializerListTest.foo({7, 8, 9});
    for (int &it : initializerListTest.vec) {
        std::cout << it << " ";
    }
    std::cout << std::endl;
    if (int tmp = initializerListTest.vec[0]; tmp < 10) {
        std::cout << "test if 1 " << tmp << std:: endl;
    }
    if (auto tmp = static_cast<float>(initializerListTest.vec[1]); tmp < 10.5f) {
        std::cout << "test if 2 " << tmp << std:: endl;
    }
}
