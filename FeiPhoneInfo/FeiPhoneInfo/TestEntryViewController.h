//
//  TestEntryViewController.h
//  FeiPhoneInfo
//
//  Created by KaiKai on 2021/8/1.
//  Copyright © 2021 TTPod. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface TestEntryItem: NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, copy) dispatch_block_t action;

- (id)initWithTitle:(NSString *)title action:(dispatch_block_t)action;

@end

@interface TestEntryViewController : UITableViewController

@end

NS_ASSUME_NONNULL_END
