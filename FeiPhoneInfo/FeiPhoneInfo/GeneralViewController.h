//
//  GeneralInfoController.h
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-26.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface GeneralViewController : BaseViewController
{
	NSArray* arrBatteryState;
	NSArray* arrOrientation;
	
	NSTimer* _timer;
	
	double _lastBatteryLevel;
	NSString* lastBacklightLevel;
}

@end
