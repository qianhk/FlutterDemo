//
// Created by KaiKai on 2020/11/8.
//

#ifndef TESTDEMO_SHAPE_H
#define TESTDEMO_SHAPE_H

#include <iostream>

using namespace std;

class Shape {
public:
    explicit Shape(int a = 0, int b = 0) {
        width = a;
        height = b;
    }

    void setWidth(int w) {
        width = w;
    }

    void setHeight(int h) {
        height = h;
    }

    static int getObjectCount() {
        return objectCount;
    }

private:
//    virtual int area() = 0;
    virtual int area() {
        cout << "Parent class area : Null" << endl;
        return 2;
    }

protected:
    int width;
    int height;

private:
    static int objectCount;
};

class Rectangle : public Shape {
public:
    explicit Rectangle(int a = 1, int b = 1) : Shape(a, b) {}

    int area() override {
        cout << "Rectangle class area :" << width * height << endl;
        return (width * height);
    }
};

class Triangle : public Shape {
public:
    explicit Triangle(int a = 1, int b = 1) : Shape(a, b) {}

    int area() final {
//        int superValue = Shape::area();
        cout << "Triangle class area :" << (width * height) / 2 << endl;
        return (width * height / 2);
    }
};

#endif //TESTDEMO_SHAPE_H
