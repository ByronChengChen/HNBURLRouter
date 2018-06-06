//
//  UIViewController+Hanabi.m
//  Hanabi
//
//  Created by 程康 on 2018/6/4.
//  Copyright © 2018年 程康. All rights reserved.
//

#import "UIViewController+Hanabi.h"

@implementation UIViewController (Hanabi)
- (UIViewController *)hnbTopViewController{
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

@end
