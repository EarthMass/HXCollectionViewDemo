//
//  AppDelegate.m
//  HXCollectionViewDemo
//
//  Created by ghx on 2020/9/10.
//  Copyright © 2020 BroSis. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

#define Is_Debug 1

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    
#if Is_Debug
    ViewController * viewC = [[NSClassFromString(@"HXAutoFitLabVC") alloc] init];
    
#else
    ViewController * viewC = [[ViewController alloc] init];
#endif

    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:viewC];
    
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}
- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(NSString *)identifier completionHandler:(void (^)(void))completionHandler {
    
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}




@end
