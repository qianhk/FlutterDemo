//
//  TestEntryViewController.m
//  FeiPhoneInfo
//
//  Created by KaiKai on 2021/8/1.
//  Copyright © 2021 TTPod. All rights reserved.
//

#import "TestEntryViewController.h"
#import "AppGlobalUI.h"

@interface TestEntryViewController ()

@property (nonatomic, strong) NSMutableArray *mTestArrasy;

@end

@interface TestEntryItem: NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, copy) dispatch_block_t action;

- (id)initWithTitle:(NSString *)title action:(dispatch_block_t)action;

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

@implementation TestEntryViewController

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
    [_mTestArrasy addObject:[[TestEntryItem alloc] initWithTitle:@"NSLog" action:^{
        NSLog(@"lookKai log From Test Entry");
    }]];
    [_mTestArrasy addObject:[[TestEntryItem alloc] initWithTitle:@"NSLog2" action:^{
        NSLog(@"lookKai log From Test Entry2");
    }]];
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
    entryItem.action();
}

@end
