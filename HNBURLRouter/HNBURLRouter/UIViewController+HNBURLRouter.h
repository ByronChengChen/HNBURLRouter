//
//  UIViewController+HNBURLRouter.h
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/14.
//  Copyright © 2017年 开发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HNBURLRouter)
//具体的控制器实现这个方法,默认使用alloc init实例化vc，也可以自定义，xib生成或者使用storyboard生成
+ (instancetype)instanceHNBViewController;

@end
