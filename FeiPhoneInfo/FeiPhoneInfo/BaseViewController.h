//
//  BaseViewController.h
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-28.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UITableViewController
{
	NSMutableDictionary* _dic;
	NSMutableArray* _arrKey;
}

- (void)configCell:(UITableViewCell *)cell;

@end
