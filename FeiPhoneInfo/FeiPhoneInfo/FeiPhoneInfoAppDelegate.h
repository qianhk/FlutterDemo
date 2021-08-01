//
//  FeiPhoneInfoAppDelegate.h
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-26.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Flutter;

@class SwitchViewController;

@interface FeiPhoneInfoAppDelegate : FlutterAppDelegate
{
	SwitchViewController* switchController;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic,strong) FlutterEngine *flutterEngine;

@end
