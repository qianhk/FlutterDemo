//
// Created by KaiKai on 2021/5/24.
//

#include "stltest.h"
#include <iostream>
#include <vector>
#include <list>
#include <set>
#include <array>
#include <unordered_map>
#include <map>
#include <algorithm>
#include <string>

using namespace std;

void stlTestShowInt(int a) {
    cout << a << ' ';
}

void printSz(const int *p, int len) {
    for (int i = 0; i < len; ++i) {
        cout << *(p + i) << '_' << p[i] << ' ';
    }
}

void stlTestMain() {
    int casts[10] = {6, 7, 2, 9, 4, 11, 8, 7, 10, 5};
    int casts2[] = {1, 2, 3, 4, 5};
    vector<int> dice(10);
    copy(casts, casts + sizeof(casts) / sizeof(casts[0]), dice.begin());
    cout << "dice: ";
    ostream_iterator<int, char> out_iter(cout, " ");
    copy(dice.begin(), dice.end(), out_iter);
    cout << endl;

    cout << "rbegin rend (implicit): ";
    copy(dice.rbegin(), dice.rend(), out_iter);
    cout << endl;

    cout << "rbegin rend (explicit): ";
    vector<int>::reverse_iterator ri;
    for (ri = dice.rbegin(); ri != dice.rend(); ++ri) {
        cout << *ri << ' ';
    }
    cout << endl;

    sort(dice.begin(), dice.end());

    cout << "rbegin rend (for_each): ";
    for_each(dice.rbegin(), dice.rend(), stlTestShowInt);
    cout << endl;

    cout << "set_union: ";
    int cast2Len = sizeof(casts2) / sizeof(casts2[0]);
    set_union(dice.begin(), dice.end(), casts2, casts2 + cast2Len, out_iter);
    cout << endl;

    vector<int> tmpVec1;
    cout << "set_intersection: ";
    //不能直接tmpVec1.begin()，没有足够空间放
//    set_intersection(dice.begin(), dice.end(), casts2, casts2 + cast2Len, tmpVec1.begin());
    auto &&tmpIter = insert_iterator<vector<int>>(tmpVec1, tmpVec1.begin());
    set_intersection(dice.begin(), dice.end(), casts2, casts2 + cast2Len, tmpIter);
    for_each(tmpVec1.begin(), tmpVec1.end(), stlTestShowInt);
    cout << endl;

    cout << "set_difference: "; //set_difference: 6 7 7 8 9 10 11  前面的迭代器中的且与后面的迭代器中不同的
    tmpVec1.clear();
    tmpIter = insert_iterator<vector<int>>(tmpVec1, tmpVec1.begin());
    set_difference(dice.begin(), dice.end(), casts2, casts2 + cast2Len, tmpIter);
    for_each(tmpVec1.begin(), tmpVec1.end(), stlTestShowInt);
    cout << endl;

    cout << "set_difference2: "; //set_difference2: 1 3
    set<int> C;
    auto &&tmpIterC = insert_iterator<set<int>>(C, C.begin());
    set_difference(casts2, casts2 + cast2Len, dice.begin(), dice.end(), tmpIterC);
    for_each(C.begin(), C.end(), stlTestShowInt);
    cout << endl;

    std::array<int, 4> arr = {1, 3, 4, 2};

    cout << "std:array: ";
// C 风格接口传参
//    printSz(arr, arr.size()); // 非法, 无法隐式转换
    printSz(&arr[0], arr.size());
    std::sort(arr.begin(), arr.end());
    cout << "    ___    ";
    printSz(arr.data(), arr.size());
    cout << endl;

    // 两组结构按同样的顺序初始化
    std::unordered_map<int, std::string> u = {
            {1, "v1"},
            {3, "v3"},
            {2, "v2"}
    };
    std::map<int, std::string> v = {
            {1, "v1"},
            {3, "v3"},
            {2, "v2"}
    };
    u.erase(1);
    v.erase(1);
    std::pair<int, string> tmpPair = {6, "v6"};
    u.insert(tmpPair);
    v.insert(tmpPair);
    u.insert({5, "v5"});
    v.insert({5, "v5"});

    std::cout << "std::unordered_map" << std::endl;
    for (const auto &n : u)
        std::cout << "Key:[" << n.first << "] Value:[" << n.second << "]\n";

    std::cout << "std::map" << std::endl;
    for (auto &&n : v)
        std::cout << "Key:[" << n.first << "] Value:[" << n.second << "]\n";
}

/*
 容器: (deque 双端队列) (list 双向链表) (queue队列) (priority_queue最大的元素被移植队首)
 stack (vector 数组容器一种表示) map multimap set multiset
 (bitset c++11后不作为容器看待，视为独立的类别)
 (array 并非stl容器，因为长度是固定的，没有调节容器大小的操作)
 c++ 11后新增: (forward_list 单链表) unordered_map  unordered_multimap unordered_multiset unordered_multiset
 前面序列容器，后面关联容器
 关联容器 set multiset map multimap 底层是基于红黑树结构,插入和搜索的平均复杂度均为 O(log(size))
 无序关联容器 unordered_set unordered_multiset unordered_map unordered_multimap 底层是基于数据结构哈希表的，提高添加和删除元素速度级提高查找算法效率 插入和搜索元素的平均复杂度为 O(constant)


 */