//
// Created by KaiKai on 2020/11/8.
//

#include "Thread.h"
// 必须的头文件是
//#include <pthread.h>

//https://github.com/changkun/modern-cpp-tutorial/blob/master/book/zh-cn/07-thread.md

void *say_hello(void *args) {
    cout << "Hello w3cschool, addr:" << args << endl;
    return nullptr;
}

void Thread::doOperate() {

//    pthread_t tids[NUM_THREADS];
//    for (auto &tid : tids) {
//        //参数依次是：创建的线程id，线程参数，调用的函数，传入的函数参数
//        int ret = pthread_create(&tid, nullptr, say_hello, tid);
//        if (ret != 0) {
//            cout << "pthread_create error: error_code=" << ret << endl;
//        }
//    }
//    //等各个线程退出后，进程才结束，否则进程强制结束了，线程可能还没反应过来；
////    pthread_exit(nullptr);
}
