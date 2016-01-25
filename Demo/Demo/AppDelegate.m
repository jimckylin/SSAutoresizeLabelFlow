//
//  AppDelegate.m
//  Demo
//
//  Created by Mrss on 16/1/25.
//  Copyright © 2016年 expai. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[[DemoViewController alloc]init]];
    self.window.rootViewController = nav;
    return YES;
}

@end
