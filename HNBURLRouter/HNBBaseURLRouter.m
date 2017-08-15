//
//  HNBBaseURLRouter.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/13.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "HNBBaseURLRouter.h"
#import "NSDictionary+Extension.h"
#import <MJExtension.h>

static NSString *const HNBRouterScheme = @"hnb://";
static NSString *const HNBRouterParamSepartor = @"?";
static NSString *const HNBRouterEqual = @"=";
static NSString *const HNBRouterAnd = @"&";


@interface HNBBaseURLRouter()


@end

@implementation HNBBaseURLRouter



+ (instancetype)shareURLRouter{
    static HNBBaseURLRouter *urlRouter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        urlRouter = [[HNBBaseURLRouter alloc] init];
    });
    
    return urlRouter;
}

- (NSMutableDictionary *)registedViewControllersDic{
    if(!_registedViewControllersDic){
        _registedViewControllersDic = [NSMutableDictionary dictionary];
    }
    return _registedViewControllersDic;
}

//远程调用
+ (id)viewControllerForRemoteUrl:(NSString *)url{
    //"http://www.baidu.com?a=10&b=20",
    //将url的参数转换成字典
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSArray <NSString *> *seperatorArray = [url componentsSeparatedByString:HNBRouterParamSepartor];
    if(seperatorArray.count > 1){
        NSString *paramsUrl = seperatorArray[1];
        if(paramsUrl){
            NSArray *paramsArray = [paramsUrl componentsSeparatedByString:HNBRouterAnd];
            for (NSString *paramUrl in paramsArray) {
                NSArray *keyValueArray = [paramUrl componentsSeparatedByString:HNBRouterEqual];
                if(keyValueArray.count > 1){
                    NSString *key = keyValueArray[0];
                    NSString *value = keyValueArray[1];
                    if(key && value){
                        params[key] = value;
                    }
                }
            }
        }
    }
    UIViewController *vc = nil;
    if(seperatorArray.count >= 1){
        vc = [self viewControllerForUrl:seperatorArray[0] withParams:params];
    }
    return vc;
}

//本地调用 无参
+ (id)viewControllerForUrl:(NSString *)url{
    id vc = [self viewControllerForUrl:url withParams:nil];
    return vc;
}

//本地调用 有参
+ (id)viewControllerForUrl:(NSString *)url withParams:(NSDictionary*)params{
    UIViewController *vcInstance = nil;
    //找到path
    NSString *urlPath = nil;
    if([url containsString:HNBRouterScheme]){
        NSArray *seperatorScheme = [url componentsSeparatedByString:HNBRouterScheme];
        for (NSString *vcUrl in seperatorScheme) {
            if(vcUrl && vcUrl.length > 0){
                urlPath = [NSString stringWithFormat:@"%@%@",HNBRouterScheme,vcUrl];
                break;
            }
        }
    }
    if(HNBBASERouterRegistedDic[urlPath]){
        Class vcClass = HNBBASERouterRegistedDic[urlPath];
        if(vcClass && [vcClass isSubclassOfClass:[UIViewController class]]){
            vcInstance = [vcClass instanceHNBViewController];
        }else{

        }
    }else{
       
    }
    
    //给vc传参
    if(params && params.allKeys.count > 0 && vcInstance){
        params = [NSDictionary hnb_removeNullFromDictionary:params];
        //TODO: chengk 将字典存到对象的各个属性里面，这个有待加强，不需要依赖mj
        [vcInstance mj_setKeyValues:params];
//        [vcInstance setValuesForKeysWithDictionary:params];
    }else{
        
    }
    return vcInstance;
}

//前提条件所有的控制器都有导航控制器的
+ (UINavigationController *)activityViewController {
    UIViewController* activityViewController = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if(tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin; break;
            }
        }
    }
    
    NSArray *viewsArray = [window subviews];
    if([viewsArray count] > 0) {
        UIView *frontView = [viewsArray objectAtIndex:0];
        id nextResponder = [frontView nextResponder];
        if([nextResponder isKindOfClass:[UIViewController class]]) {
            activityViewController = nextResponder;
        } else {
            activityViewController = window.rootViewController;
        }
    }
    return (UINavigationController*)activityViewController;
}

@end
