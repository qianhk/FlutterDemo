//
//  DemoBoostDelegate.m
//  FeiPhoneInfo
//
//  Created by KaiKai on 2021/8/1.
//  Copyright © 2021 TTPod. All rights reserved.
//

#import "DemoFlutterBoostDelegate.h"
#import <flutter_boost/FlutterBoost.h>

@interface DemoFlutterBoostDelegate ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, void(^)(NSDictionary*)> *resultTable;

@end

@implementation DemoFlutterBoostDelegate

//@optional
//- (FlutterEngine*) engine;
//@required


- (id)init
{
    self = [super init];
    if (self)
    {
        _resultTable = [NSMutableDictionary new];
    }
    return self;
}

///如果框架发现您输入的路由表在flutter里面注册的路由表中找不到，那么就会调用此方法来push一个纯原生页面
- (void) pushNativeRoute:(NSString *) pageName arguments:(NSDictionary *) arguments {
    //可以用参数来控制是push还是pop
    BOOL isPresent = arguments[@"isPresent"];
    BOOL isAnimated = arguments[@"isAnimated"] != nil ? [arguments[@"isAnimated"] boolValue] : YES;
    //这里根据pageName来判断生成哪个vc，这里给个默认的了
    UIViewController  *targetViewController = [UIViewController new];
    
    if(isPresent) {
        [_navController presentViewController:targetViewController animated:isAnimated completion:nil];
    } else {
        [_navController pushViewController:targetViewController animated:isAnimated];
    }
}

///当框架的withContainer为true的时候，会调用此方法来做原生的push
- (void) pushFlutterRoute:(FlutterBoostRouteOptions *)options {
    FBFlutterViewContainer *flutterVc = [FBFlutterViewContainer new];
    [flutterVc setName:options.pageName uniqueId:options.uniqueId params:options.arguments opaque:options.opaque];
    NSDictionary *arguments = options.arguments;
    BOOL isPresent = arguments[@"isPresent"];
    BOOL isAnimated = arguments[@"isAnimated"] != nil ? [arguments[@"isAnimated"] boolValue] : YES;
    _resultTable[options.pageName] = options.onPageFinished;
    
    //如果是present模式 ，或者要不透明模式，那么就需要以present模式打开页面
    if(isPresent || !options.opaque){
        [_navController presentViewController:flutterVc animated:isAnimated completion:nil];
    }else{
        [_navController pushViewController:flutterVc animated:isAnimated];
    }
}

///当pop调用涉及到原生容器的时候，此方法将会被调用
- (void) popRoute:(FlutterBoostRouteOptions *)options {
    //如果当前被present的vc是container，那么就执行dismiss逻辑
    UIViewController *vc = _navController.presentedViewController;
    NSString *uniqueId = nil;
    if ([vc isKindOfClass:FBFlutterViewContainer.class]) {
        uniqueId = ((FBFlutterViewContainer *)vc).uniqueIDString;
    }
    if ([options.uniqueId isEqualToString:uniqueId]) {
        if (vc.modalPresentationStyle == UIModalPresentationOverFullScreen) {
            [_navController.topViewController beginAppearanceTransition:YES animated:NO];
            [vc dismissViewControllerAnimated:YES completion:^{
                            [_navController.topViewController endAppearanceTransition];
            }];
        } else {
            [vc dismissViewControllerAnimated:YES completion:nil];
        }
    } else {
        [_navController popViewControllerAnimated:YES];
    }
    
    //否则直接执行pop逻辑
    //这里在pop的时候将参数带出,并且从结果表中移除
    void(^onPageFinished)(NSDictionary*) = _resultTable[options.pageName];
    if (onPageFinished != nil) {
        onPageFinished(options.arguments);
        [_resultTable removeObjectForKey:options.pageName];
    }

}

@end
