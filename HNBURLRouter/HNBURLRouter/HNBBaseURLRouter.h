//
//  HNBBaseURLRouter.h
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/13.
//  Copyright © 2017年 开发. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIViewController+HNBURLRouter.h"
#define HNBBASERouterRegistedDic ([HNBBaseURLRouter shareURLRouter].registedViewControllersDic)

@interface HNBBaseURLRouter : NSObject
@property (nonatomic, strong) NSMutableDictionary <NSString *,Class>*registedViewControllersDic;

+ (instancetype)shareURLRouter;

/**
 *  远程调用
 */
+ (id)viewControllerForRemoteUrl:(NSString *)url;

/**
 * 本地调用 无参
 */
+ (id)viewControllerForUrl:(NSString *)url;

/**
 * 本地调用有参
 */
+ (id)viewControllerForUrl:(NSString *)url withParams:(NSDictionary*)params;

@end

NS_INLINE void hnbRouterRegistUrlForViewcontroller(NSString* routeAddress,id vcClass){
    [HNBBaseURLRouter shareURLRouter].registedViewControllersDic[routeAddress] = [vcClass class];
}
