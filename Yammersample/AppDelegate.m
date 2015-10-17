//
//  AppDelegate.m
//  Yammersample
//
//  Created by Ashok on 06/10/15.
//  Copyright (c) 2015 Ashok. All rights reserved.
//

#import "AppDelegate.h"
#import <YammerSDK/YMLoginClient.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //Configure credential for yammer login
    [self configureLoginClient];
   
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
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    // If we arrive here it means the login was successful, so now let's get the authToken to be used on all subsequent requests
    //-[YMLoginCClient handleLoginRedirectFromUrl:sourceApplication:]
    if ([[YMLoginClient sharedInstance] handleLoginRedirectFromUrl:url sourceApplication:sourceApplication])
        return YES;
    
    // URL was not a match, or came from an application other than Safari
    return NO;
}
#pragma custom method
- (void)configureLoginClient
{
    /* Add your client ID here */
    [[YMLoginClient sharedInstance] setAppClientID:@"Xs4faJiKI6bUL9XF9tAOA"];
    
    /* Add your client secret here */
    [[YMLoginClient sharedInstance] setAppClientSecret:@"0apnVkkWsv8EnUDm4gYL4pjrk2DvY58anDeLJDyGo"];
    
    /* Add your authorization redirect URI here */
    [[YMLoginClient sharedInstance] setAuthRedirectURI:@"movetoyammersample://example.com"];
}
@end
