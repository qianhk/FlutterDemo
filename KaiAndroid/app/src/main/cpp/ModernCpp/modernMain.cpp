#include <iostream>
#include <cstring>
#include "Shape.h"
#include "virtual_derived.h"
#include "FileOperate.h"
#include "Temple.hpp"
#include "Thread.h"
#include "ModelCxx.h"
#include "usability.h"
#include "pointers.h"
#include "regextest.h"
#include "teststd17.h"
#include "stringformat.h"

using namespace std;

void printBook(struct Books *book);

typedef struct Books {
    char title[50];
    char author[50];
    char subject[100];
    int book_id;
} Books;

struct Storage {
    char      a;
    int       b;
    double    c;
    long long d;
};

struct alignas(std::max_align_t) AlignasStorage {
    char      a;
    int       b;
    double    c;
    long long d;
};

int mainModerns() {
    Books Book1;        // 定义结构体类型 Books 的变量 Book1
    Books Book2;        // 定义结构体类型 Books 的变量 Book2

    // Book1 详述
    strcpy(Book1.title, "C++ 教程");
    strcpy(Book1.author, "Runoob");
    strcpy(Book1.subject, "编程语言");
    Book1.book_id = 12345;

    // Book2 详述
    strcpy(Book2.title, "CSS 教程");
    strcpy(Book2.author, "Runoob");
    strcpy(Book2.subject, "前端技术subtitle");
    Book2.book_id = 12346;

    // 通过传 Book1 的地址来输出 Book1 信息
    printBook(&Book1);

    // 通过传 Book2 的地址来输出 Book2 信息
    printBook(&Book2);

    Rectangle rect = Rectangle(5, 6);
//    rect.setWidth(5);
//    rect.setHeight(7);

    cout << endl;

    C c;   //D, B, A ,C
    cout << sizeof(c) << endl;

    Triangle triangle = Triangle(5, 6);

    // 输出对象的面积
    cout << "Total area: " << rect.area() << endl;
    cout << "Total area: " << triangle.area() << endl;
    cout << "object count: " << Rectangle::getObjectCount() << endl;

//    Shape *shape;
//    shape = &rect;
//    cout << "rect address " << shape->area() << endl;
//    shape = &triangle;
//    cout << "triangle address " << shape->area() << endl;
//    shape = new Shape();
//    cout << "shape address " << shape->area() << endl;

    FileOperate fileOperate;
//    fileOperate.doOperate();

//    int a = 1;
//    int b = 0;

//    int divZero = 100 / 0;
//    cout << "after 1/0=" << divZero << endl;

    int i = 39;
    int j = 20;
    cout << "Max(i, j): " << Max(i, j) << endl;

    double f1 = 13.5;
    double f2 = 20.7;
    cout << "Max(f1, f2): " << Max(f1, f2) << endl;

    string s1 = "Hello";
    string s2 = "World";
    cout << "Max(s1, s2): " << Max(s1, s2) << endl;

    try {
        Stack<int> intStack;  // int 类型的栈
        Stack<string> stringStack;    // string 类型的栈

        // 操作 int 类型的栈
        intStack.push(7);
        cout << intStack.top() << endl;

        // 操作 string 类型的栈
        stringStack.push("hello");
        cout << stringStack.top() << std::endl;
        stringStack.pop();
        stringStack.pop();
    }
    catch (exception const &ex) {
        cout << "Exception: " << ex.what() << endl;
//        return -1;
    }

    Thread thread;
//    thread.doOperate();

    cout << "lookKai model Cxx" << endl;
    usabilityMain();
    modelRuntimeTest();
    pointersMain();
    regexTestMain();

    //mac os: alignof(Storage): 8    alignof(AlignasStorage): 16
    std::cout << "alignof(Storage): " << alignof(Storage) << "    alignof(AlignasStorage): " << alignof(AlignasStorage) << std::endl;

    testStd17Main();

    stringFormatMain();

    return 0;
}

// 该函数以结构指针作为参数
void printBook(Books *book) {
    cout << "书标题 : " << book->title << endl;
    cout << "书作者 : " << book->author << endl;
    cout << "书类目 : " << book->subject << endl;
    cout << "书 ID : " << book->book_id << endl;
}