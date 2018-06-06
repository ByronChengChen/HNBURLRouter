//
//  UITabBarController+Hanabi.h
//  Hanabi
//
//  Created by 程康 on 2018/5/31.
//  Copyright © 2018年 程康. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (Hanabi)
- (instancetype)initWithControllers:(NSArray <UIViewController *> *)controllers;
- (void)hnbSetTabBarTintColor:(UIColor *)tintColor;
+ (void)hnbSetController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName;

@end
