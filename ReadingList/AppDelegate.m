//
//  AppDelegate.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "AppDelegate.h"
#import "REDBookListViewController.h"
#import "REDDepedencyInjection.h"
#import "Depend/DPInjector.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Application Delegate
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [DPInjector inject];
    [REDDepedencyInjection registerImplementations];
    
    REDBookListViewController *bookList = [[REDBookListViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:bookList];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}
-(void)applicationWillResignActive:(UIApplication *)application {

}
-(void)applicationDidEnterBackground:(UIApplication *)application {

}
-(void)applicationWillEnterForeground:(UIApplication *)application {
}
-(void)applicationDidBecomeActive:(UIApplication *)application {
}
-(void)applicationWillTerminate:(UIApplication *)application {

}

@end
