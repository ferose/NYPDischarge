//
//  AppDelegate.m
//  Discharge
//
//  Created by Ferose Babu on 3/12/16.
//  Copyright © 2016 NYP. All rights reserved.
//

#import "AppDelegate.h"
#import "Authorization.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[Authorization shared] appStart];
    
/* 
NYP Hospital COLORS:
red: 223, 74, 50
light grey: 187, 187, 187
dark grey: 122, 121, 121
black:
 
*/
    // remove translucent layer on navigation items
    [UINavigationBar appearance].translucent = NO;
    [UITabBar appearance].translucent = NO;
    
    // change top navigation bar button color
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    // change navigation bar background color
    [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:223/256.0 green:74/256.0 blue:50/256.0 alpha:1.0];
    

    
    
    // tab bar controller background
//    UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
//    UITabBarController *bc = nav.viewControllers[0];
//    bc.tabBar.barTintColor = [UIColor colorWithRed:122/256.0 green:121/256.0 blue:121/256.0 alpha:1.0];

    
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
