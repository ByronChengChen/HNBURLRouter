//
//  AppDelegate+HNBURLRouter.m
//  Hanabi
//
//  Created by 程康 on 2018/5/31.
//  Copyright © 2018年 程康. All rights reserved.
//

#import "AppDelegate+HNBURLRouter.h"
#import "UIViewController+Hanabi.h"
@interface AppDelegate()
@end

@implementation AppDelegate (HNBURLRouter)
- (void)setHNBRouterConfigDelegate{
    [HNBBaseURLRouter startWithConfig:(id<HNBRouterConfig>)self];
}


- (UITabBarController *)hnbTabBarController{
    return self.tabBarController;
}

- (NSString *)hnbSchemeName{
    return @"hanabi://hnb/";
}

- (UIViewController *)hnbRouterTopViewController{
    return [ApplicationDelegate.tabBarController hnbTopViewController]
    ;
}

@end
