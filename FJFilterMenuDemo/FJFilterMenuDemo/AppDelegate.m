//
//  AppDelegate.m
//  FJFilterMenuDemo
//
//  Created by Jeff on 2017/4/7.
//  Copyright © 2017年 Jeff. All rights reserved.
//

#import "AppDelegate.h"
#import "SearchRootViewController.h"
#import <FJController/FJControllerHeader.h>
#import <FJTool/FJTool.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Tabbar
    FJTabItem *homeTabItem = [FJTabItem tabItem:@"Home"
                                unselectedImage:@"tabbar_home"
                                  selectedImage:@"tabbar_home_selected"
                            unselectedTextAttrs:@{NSForegroundColorAttributeName:COLOR_GRAY_CCCCCC, NSFontAttributeName:FONT_LIGHT_10}
                              selectedTextAttrs:@{NSForegroundColorAttributeName:COLOR_GRAY_26241F, NSFontAttributeName:FONT_LIGHT_10}
                                     controller:[SearchRootViewController class]];
    [[FJControllerMgr sharedInstance] setTabItems:@[homeTabItem]];
    
    FJTabBarConfig *tabBarConfig = [FJTabBarConfig tabBarConfig:nil  // @"tabbar_background"
                                                    disableLine:NO
                                                    translucent:NO
                                                   barTintColor:[UIColor whiteColor]
                                                  selectedColor:COLOR_GRAY_26241F
                                                unselectedColor:COLOR_GRAY_CCCCCC];
    [[FJControllerMgr sharedInstance] setTabBarConfig:tabBarConfig];
    
    // Navbar
    FJNavBarConfig *navBarConfig = [FJNavBarConfig navBarConfig:[UIImage imageNamed:@"nav_back_grey"]
                                                  imageBackSize:CGSizeZero
                                              navbarTranslucent:NO
                                                navbarTintColor:[UIColor whiteColor]
                                                     titleColor:COLOR_GRAY_26241F
                                                      titleFont:[UIFont systemFontOfSize:18.0]];
    [[FJControllerMgr sharedInstance] setNavBarConfig:navBarConfig];
    
    // Controller Common
    FJCommonControllerConfig *commonControllerConfig = [[FJCommonControllerConfig alloc] init];
    commonControllerConfig.backgroundColor = COLOR_TEXT_PURPLE;
    [[FJControllerMgr sharedInstance] setCommonControllerConfig:commonControllerConfig];
    
    FJTabViewController *tabViewController = [[FJTabViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self.window setRootViewController:tabViewController];
    
    return YES;
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
