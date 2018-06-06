//
//  AppDelegate.m
//  HNBURLRouterDemo
//
//  Created by 程康 on 2018/6/6.
//  Copyright © 2018年 程康. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+HNBURLRouter.h"
#import "UITabBarController+Hanabi.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    UITabBarController *tabBarController = [self getTabBarController];
    self.window.rootViewController = tabBarController;
    self.tabBarController = tabBarController;
    [self setHNBRouterConfigDelegate];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (UITabBarController *)getTabBarController{
    NSArray *controller = [self getTabControllers];
    UITabBarController *tabBarController = [[UITabBarController alloc] initWithControllers:controller];
    [tabBarController hnbSetTabBarTintColor:[UIColor redColor]];
    return tabBarController;
}

- (UIViewController *)getViewControllerWithUrl:(NSString *)url title:(NSString *)title imageName:(NSString *)imageName{
    UIViewController *vc = [HNBBaseURLRouter viewControllerForUrl:url];
    [UITabBarController hnbSetController:vc title:title imageName:imageName];
    return vc;
}

- (NSArray <UIViewController *>*)getTabControllers{
    NSMutableArray *controllers = [NSMutableArray array];
    [controllers addObject:[self getViewControllerWithUrl:HNBURLMe title:@"我的" imageName:@"tabbar_me_normal"]];
    [controllers addObject:[self getViewControllerWithUrl:HNBURLDiscovery title:@"发现" imageName:@"tabbar_discover"]];
    [controllers addObject:[self getViewControllerWithUrl:HNBURLInteraction title:@"互动" imageName:@"tabbar_interaction"]];
    [controllers addObject:[self getViewControllerWithUrl:HNBURLAccount title:@"账号" imageName:@"tabbar_account"]];
    return controllers;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
