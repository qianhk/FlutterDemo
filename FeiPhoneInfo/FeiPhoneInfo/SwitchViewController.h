//
//  SwitchViewController.h
//  FeiPhoneInfo
//
//  Created by hongkai.qian on 11-9-26.
//  Copyright 2011年 TTPod. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GeneralViewController;
@class TaskViewController;
@class ProfilesViewController;
@class NetworkViewController;
@class CameraViewController;
@class HardwareViewController;
@class AboutViewController;
@class TestEntryViewController;

@interface SwitchViewController : UIViewController<UITabBarDelegate>
{
	UIView* bkgView;
	UIImageView* imgView;
	UITabBar* tabBar;
	UITabBarItem* tabBarItem0;
	UITabBarItem* tabBarItem1;
	UITabBarItem* tabBarItem2;
	UITabBarItem* tabBarItem3;
	UITabBarItem* tabBarItem4;
	UITabBarItem* tabBarItem5;
	UITabBarItem* tabBarItem6;
    UITabBarItem* tabBarItem7;
	
	GeneralViewController* generalController;
	TaskViewController*	taskController;
	ProfilesViewController* profilesController;
	NetworkViewController* networkController;
	CameraViewController* cameraController;
	HardwareViewController* hardwareController;
	AboutViewController* aboutController;
    TestEntryViewController *testEntryController;
	
//	CGRect _rectbottom;
}

@end
