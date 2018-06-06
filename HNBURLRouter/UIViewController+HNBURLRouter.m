//
//  UIViewController+HNBURLRouter.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/14.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "UIViewController+HNBURLRouter.h"

@implementation UIViewController (HNBURLRouter)

+ (instancetype)instanceHNBViewController{
    return [[self alloc] init];
}

//!!!: chengk info 留给子类自定义设置参数
- (void)hnbSetParams:(NSDictionary *)params{
    if(!params){
        return;
    }
    [self setValuesForKeysWithDictionary:params];
}

- (NSInteger)hnbIndex{
    return NSNotFound;
}

@end
