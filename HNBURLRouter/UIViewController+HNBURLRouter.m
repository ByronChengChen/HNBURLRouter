//
//  UIViewController+HNBURLRouter.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/14.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "UIViewController+HNBURLRouter.h"
#import "NSDictionary+HNBExtension.h"

@implementation UIViewController (HNBURLRouter)

+ (instancetype)instanceHNBViewController{
    return [[self alloc] init];
}

//!!!: chengk info 留给子类自定义设置参数
- (void)hnbSetParams:(NSDictionary *)params{
    if(!params){
        return;
    }
    params = [NSDictionary hnb_removeNullFromDictionary:params];
    //这里 key params 的值不存在的情况在 dictionaryWithObjects 方法中已经屏蔽了，在 forUndefinedKey 中屏蔽了 vc 的key不存在
    [self setValuesForKeysWithDictionary:params];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"file:%s,fun:%s,line:%d,key:%@ not exit",__FILE__ ,__func__,__LINE__,key);
}

- (NSInteger)hnbIndex{
    return NSNotFound;
}

@end
