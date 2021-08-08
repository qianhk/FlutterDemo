//
//  TestEntryViewController.m
//  FeiPhoneInfo
//
//  Created by KaiKai on 2021/8/1.
//  Copyright © 2021 TTPod. All rights reserved.
//

#import "TestEntryViewController.h"
#import "AppGlobalUI.h"
#import "FeiPhoneInfoAppDelegate.h"
@import Flutter;
//#import <flutter_boost/FlutterBoost.h>

@interface TestEntryViewController ()

@property (nonatomic, strong) NSMutableArray *mTestArrasy;

@end

@implementation TestEntryViewController

- (void)initEntryList {
    __weak typeof(self) weakSelf = self;
    [_mTestArrasy addObject:[[TestEntryItem alloc] initWithTitle:@"NSLog" action:^{
        NSLog(@"lookKai log From Test Entry");
    }]];
    [_mTestArrasy addObject:[[TestEntryItem alloc] initWithTitle:@"Normal Native VC" action:^{
        [self.navigationController pushViewController:[UIViewController new] animated:YES];
    }]];
    
    [_mTestArrasy addObject:[[TestEntryItem alloc] initWithTitle:@"Normal Native With PageName" action:^{
        [weakSelf showFlutterDemoUseBoostWith:@"/unexist_flutter_page"];
    }]];
    
    [_mTestArrasy addObject:[[TestEntryItem alloc] initWithTitle:@"Flutter Demo: /home" action:^{
        [weakSelf showFlutterDemoUseBoost];
    }]];
    
    [_mTestArrasy addObject:[[TestEntryItem alloc] initWithTitle:@"Flutter Demo: provider_shopper" action:^{
        [weakSelf showFlutterDemoUseBoostWith:@"/provider_shopper_page_login"];
    }]];
    
  
}

- (void)showFlutterDemoUseBoost {
//    FlutterBoostRouteOptions *options = [FlutterBoostRouteOptions new];
//    options.pageName = @"/home";
//    options.arguments = @{@"key_kai" :@"value_kai", @"key_int": @666};
//
//    //页面是否透明（用于透明弹窗场景），若不设置，默认情况下为true
//    options.opaque = true;
//
//    //这个是push操作完成的回调，而不是页面关闭的回调！！！！
//    options.completion = ^(BOOL success) {
//        NSLog(@"lookKai openPage completion: %@", @(success));
//    };
//
//
//    options.onPageFinished = ^(NSDictionary *resultDic){
//        NSLog(@"lookKai openPage onPageFinished result=%@", resultDic);
//    };
//
//    [FlutterBoost.instance open:options];
    
    FlutterEngine *flutterEngine =
            ((FeiPhoneInfoAppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
    FlutterViewController *flutterVc =
            [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    [self.navigationController pushViewController:flutterVc animated:YES];
}


- (void)showFlutterDemoUseBoostWith:(NSString *)pageName {
//    FlutterBoostRouteOptions *options = [FlutterBoostRouteOptions new];
//    options.pageName = pageName;
//
//    //这个是push操作完成的回调，而不是页面关闭的回调！！！！
//    options.completion = ^(BOOL success) {
//        NSLog(@"lookKai openPage completion: %@", @(success));
//    };
//
//
//    options.onPageFinished = ^(NSDictionary *resultDic){
//        NSLog(@"lookKai openPage onPageFinished result=%@", resultDic);
//    };
//
//    [FlutterBoost.instance open:options];
    
    FlutterEngine *flutterEngine = ((FeiPhoneInfoAppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
//    flutterEngine.page
    FlutterViewController *flutterVc = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
    [self.navigationController pushViewController:flutterVc animated:YES];
}

- (void)showFlutterDemo {
    FlutterEngine *flutterEngine = ((FeiPhoneInfoAppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
    FlutterViewController *flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
//    [self presentViewController:flutterViewController animated:YES completion:nil];
//    self.parentViewController
    [self.navigationController pushViewController:flutterViewController animated:YES];
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGFloat topHeight = kStatusBarHeight;
    CGRect rectView = CGRectMake(0, topHeight, rect.size.width, rect.size.height - topHeight - kTabBarHeight);
    self.view.frame = rectView;
    
    // Do any additional setup after loading the view.
    _mTestArrasy = [NSMutableArray new];
    [self initEntryList];

    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"TestEntryCell"];
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_mTestArrasy count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TestEntryCell"];
//    if (cell == nil)
//    {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
////        [self configCell:cell];
//        cell.textLabel.font = [UIFont systemFontOfSize:16];
//    }
    

    TestEntryItem* entryItem = [_mTestArrasy objectAtIndex:[indexPath row]];
    cell.textLabel.text = entryItem.title;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 34.0f;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TestEntryItem* entryItem = [_mTestArrasy objectAtIndex:[indexPath row]];
    NSLog(@"lookKai click entry: %@", entryItem.title);
    entryItem.action();
}

@end



@implementation TestEntryItem

- (id)initWithTitle:(NSString *)title action:(dispatch_block_t) action {
    self = [super init];
    if (self) {
        _title = title;
        _action = action;
    }
    return self;
}
@end

