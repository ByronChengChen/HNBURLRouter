//
//  HNBBaseURLRouter.m
//  HNBKitDemo
//
//  Created by 开发 on 2017/7/13.
//  Copyright © 2017年 开发. All rights reserved.
//

#import "HNBBaseURLRouter.h"
#import "NSDictionary+Extension.h"
static NSString *const HNBRouterParamSepartor = @"?";
static NSString *const HNBRouterEqual = @"=";
static NSString *const HNBRouterAnd = @"&";


@interface HNBBaseURLRouter()
//SchemeName 可以配置 通过config
@property (nonatomic, weak) id<HNBRouterConfig> config;
@end

@implementation HNBBaseURLRouter

+ (void)startWithConfig:(id<HNBRouterConfig>)config{
    [HNBBaseURLRouter shareURLRouter].config = config;
}

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
//    //找到path 啥意思？没用的话，删掉吧
//    NSString *urlPath = nil;
//    if([url containsString:[[HNBBaseURLRouter shareURLRouter].config hnbSchemeName]]){
//        NSArray *seperatorScheme = [url componentsSeparatedByString:[[HNBBaseURLRouter shareURLRouter].config hnbSchemeName]];
//        for (NSString *vcUrl in seperatorScheme) {
//            if(vcUrl && vcUrl.length > 0){
//                urlPath = [NSString stringWithFormat:@"%@%@",[[HNBBaseURLRouter shareURLRouter].config hnbSchemeName],vcUrl];
//                break;
//            }
//        }
//    }
    if(HNBBASERouterRegistedDic[url]){
        Class vcClass = HNBBASERouterRegistedDic[url];
        if(vcClass && [vcClass isSubclassOfClass:[UIViewController class]]){
            vcInstance = [vcClass instanceHNBViewController];
        }else{
            
        }
    }else{
       
    }
    
    //给vc传参
    if(params && params.allKeys.count > 0 && vcInstance){
        params = [NSDictionary hnb_removeNullFromDictionary:params];
        //可能需要自定义设置params
        if([vcInstance respondsToSelector:@selector(hnbSetParams:)]){
            [vcInstance hnbSetParams:params];
        }else{
            [vcInstance setValuesForKeysWithDictionary:params];
        }
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

+ (id)openURL:(NSString *)urlString{
    //hanabi://hnb?param1=oneValue&param2=twoValue&param3=threeValue
    NSArray <NSString*>*arr = [urlString componentsSeparatedByString:HNBRouterParamSepartor];
    NSMutableDictionary *params = @{}.mutableCopy;
    if (arr.count > 1) {
        for (NSString *string in [arr[1] componentsSeparatedByString:HNBRouterAnd]) {
            NSString *key = [string componentsSeparatedByString:HNBRouterEqual][0];
            NSString *value = [string componentsSeparatedByString:HNBRouterEqual][1];
            [params setObject:value forKey:key];
        }
    }
    return [self openURL:arr[0] withParams:params];
}

+ (id)openURL:(NSString *)urlString withParams:(NSDictionary *)params{
    UIViewController *vc = [self viewControllerForUrl:urlString withParams:params];
    NSInteger tabIndex = [vc hnbIndex];
    UIViewController *currentVC = [HNBBaseURLRouter shareURLRouter].config.hnbRouterTopViewController;
    UINavigationController *currentNaviController = nil;
    if ([currentVC isKindOfClass:[UINavigationController class]]) {
        currentNaviController = (UINavigationController*)currentVC;
    }else {
        currentNaviController = currentVC.navigationController;
    }
    if(tabIndex != NSNotFound){
        [currentNaviController popToRootViewControllerAnimated:NO];
        [HNBBaseURLRouter shareURLRouter].config.hnbTabBarController.selectedIndex = tabIndex;
        vc = [HNBBaseURLRouter shareURLRouter].config.hnbTabBarController.selectedViewController;
    }else{
        [currentNaviController pushViewController:vc animated:YES];
    }
    return vc;
}

//present出来的vc一定要携带 navigtion
+ (id)presentControllerWithURL:(NSString *)urlString withParams:(NSDictionary *)params prepreBlock:(PresentControllerBlock)presentBlock animated:(BOOL)animated completionBlock:(void (^)(void))completion{
    UIViewController *vc = [self viewControllerForUrl:urlString withParams:params];
//    UITabBarController *tabBarController = [HNBBaseURLRouter shareURLRouter].config.hnbTabBarController;
    UIViewController *topViewController = [HNBBaseURLRouter shareURLRouter].config.hnbRouterTopViewController;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    if(presentBlock){
        presentBlock(nav);
    }
    [topViewController presentViewController:nav animated:animated completion:completion];
    return vc;
}

@end
