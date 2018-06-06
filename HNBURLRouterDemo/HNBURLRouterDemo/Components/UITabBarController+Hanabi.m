//
//  UITabBarController+Hanabi.m
//  Hanabi
//
//  Created by 程康 on 2018/5/31.
//  Copyright © 2018年 程康. All rights reserved.
//

#import "UITabBarController+Hanabi.h"

@implementation UITabBarController (Hanabi)

- (instancetype)initWithControllers:(NSArray <UIViewController *> *)controllers{
    if(self = [super init]){
        NSMutableArray *naviControllers = [NSMutableArray array];
        [controllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:obj];
            [naviControllers addObject:nav];
        }];
        self.viewControllers = naviControllers;
    }
    return self;
}

- (void)hnbSetTabBarTintColor:(UIColor *)tintColor{
    self.tabBar.tintColor = tintColor;
}

+ (void)hnbSetController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName{
    controller.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:imageName];
}

@end
