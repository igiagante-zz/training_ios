//
//  AppDelegate.m
//  tabs
//
//  Created by Ignacio Giagante on 30/7/16.
//  Copyright © 2016 Ignacio Giagante. All rights reserved.
//

#import "AppDelegate.h"
#import "ListViewController.h"
#import "ItemViewController.h"
#import "JUKLTabBarViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    JUKLTabBarViewController *tabBarController = [[JUKLTabBarViewController alloc] init];
    
    ListViewController* vc1 = [[ListViewController alloc] init];
    
    ItemViewController* vc2 = [[ItemViewController alloc] init];
    
    NSArray* controllers = [NSArray arrayWithObjects:vc1, vc2, nil];
    tabBarController.viewControllers = controllers;
    
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    
    tabBarItem1.title = @"List";
    tabBarItem2.title = @"Item";
    
    tabBarItem1.image = [self imageWithImage:[UIImage imageNamed:@"ic_list.jpg"] scaledToSize:CGSizeMake(30, 30)];
    tabBarItem2.image = [self imageWithImage:[UIImage imageNamed:@"ic_item.jpg"] scaledToSize:CGSizeMake(30, 30)];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:tabBarController];
    
    navController.navigationBar.barStyle = UIBarStyleDefault;
    navController.navigationBar.tintColor = [UIColor blueColor];
    navController.navigationBar.backgroundColor = [UIColor grayColor];
    navController.navigationBar.opaque = YES;
    navController.navigationBar.translucent = NO;

    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];

    
    return YES;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
