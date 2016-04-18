//
//  CCSAppDelegate.m
//  CocoaChartsSample
//
//  Created by limc on 2014/03/07.
//  Copyright (c) 2014年 limc. All rights reserved.
//

#import "CCSAppDelegate.h"
#import "CCSViewController.h"
#import "CCSDetailViewController.h"

@implementation CCSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        self.viewController = [[UINavigationController alloc] initWithRootViewController:[[CCSViewController alloc] init]];
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = [[UISplitViewController alloc] init];
        UINavigationController *leftNavigationController = [[UINavigationController alloc] initWithRootViewController:[[CCSViewController alloc] init]];
        UINavigationController *rightNavigationController = [[UINavigationController alloc] initWithRootViewController:[[CCSDetailViewController alloc] init]];
        splitViewController.viewControllers = [NSArray arrayWithObjects:leftNavigationController, rightNavigationController, nil];
        self.viewController = splitViewController;
    }
    self.window.rootViewController = self.viewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
