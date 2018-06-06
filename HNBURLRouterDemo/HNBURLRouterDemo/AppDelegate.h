//
//  AppDelegate.h
//  HNBURLRouterDemo
//
//  Created by 程康 on 2018/6/6.
//  Copyright © 2018年 程康. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ApplicationDelegate ((AppDelegate*)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UITabBarController *tabBarController;
@property (nonatomic, assign) NSInteger testPresentedNumber;

@end

