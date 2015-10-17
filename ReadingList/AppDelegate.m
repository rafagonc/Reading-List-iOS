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
#import "REDStaticData.h"
#import "UIColor+ReadingList.h"
#import "REDDataStack.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>


@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Application Delegate
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[[Crashlytics class]]];
    [DPInjector inject];
    [REDDepedencyInjection registerImplementations];
    [REDStaticData craateStaticData];
    
    REDBookListViewController *bookList = [[REDBookListViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:bookList];
    self.window.backgroundColor = [UIColor red_redColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
