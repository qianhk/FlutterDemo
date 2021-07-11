//
//  main.m
//  KaiTestCpp
//
//  Created by KaiKai on 2021/7/11.
//

#import <Foundation/Foundation.h>
#import "KaiTest.hpp"

void test_my_code() {
    BaseClass baseClass = BaseClass(3000);
    DerivedClass derivedClass = DerivedClass();
    BaseClass *pBase = &baseClass;
    DerivedClass *pDerived = &derivedClass;

    pBase = pDerived;
    pDerived = dynamic_cast<DerivedClass *>(pBase); // ok
    pBase = &baseClass;
    pDerived = dynamic_cast<DerivedClass *>(pBase); // return 0
    pDerived->printInfoVirtual(); //
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        test_my_code();
    }
    return 0;
}
