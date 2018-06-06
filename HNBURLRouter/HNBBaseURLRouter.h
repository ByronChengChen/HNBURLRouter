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

typedef void(^PresentControllerBlock) (UIViewController *);

#define HNBURLRouterRegistUrl(args) \
+ (void)load {\
HNBBASERouterRegistedDic[args] = [self class];\
}

#define HNBBASERouterRegistedDic ([HNBBaseURLRouter shareURLRouter].registedViewControllersDic)

@protocol HNBRouterConfig <NSObject>

@required

/**
 @return 需要知道整个app的UITabBarController
 */
- (UITabBarController *)hnbTabBarController;

/**
 @return 跳转协议名称 example: "app://page1/action1" 则返回app
 */
- (NSString *)hnbSchemeName;


/**
 nav和present系统中最上层 controller
 @return hnbRouterTopViewController
 */
- (UIViewController *)hnbRouterTopViewController;

@end

@interface HNBBaseURLRouter : NSObject
@property (nonatomic, strong) NSMutableDictionary <NSString *,Class>*registedViewControllersDic;

/**
 必要，启动app时调用，写入配置
 
 @param config 配置
 */
+ (void)startWithConfig:(id<HNBRouterConfig>)config;

+ (instancetype)shareURLRouter;

/**
 *  远程调用 ：适用于h5中按钮触发的新页面，直接传入一个url，在url中携带参数，最终调用的也是本地调用方法
 */
+ (id)viewControllerForRemoteUrl:(NSString *)url;

/**
 * 本地调用 无参
 */
+ (id)viewControllerForUrl:(NSString *)url;

/**
 * 本地调用有参 ：调用时候，url无须携带传入的参数，参数在params设置
 */
+ (id)viewControllerForUrl:(NSString *)url withParams:(NSDictionary*)params;

/**
 * 获取屏幕最上方的导航控制器
 */
+ (UINavigationController *)activityViewController;

+ (id)openURL:(NSString *)urlString;

+ (id)openURL:(NSString *)urlString withParams:(NSDictionary *)params;

+ (id)presentControllerWithURL:(NSString *)urlString withParams:(NSDictionary *)params prepreBlock:(PresentControllerBlock)presentBlock animated:(BOOL)animated completionBlock:(void (^)(void))completion;

@end

NS_INLINE void hnbRouterRegistUrlForViewcontroller(NSString* routeAddress,id vcClass){
    [HNBBaseURLRouter shareURLRouter].registedViewControllersDic[routeAddress] = [vcClass class];
}
