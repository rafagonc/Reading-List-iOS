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
#import "REDRecommendedBooksViewController.h"
#import "REDCloudMigrationHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Application Delegate
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[[Crashlytics class]]];
    [DPInjector inject];
    [REDDepedencyInjection registerImplementations];
    [REDCloudMigrationHandler migrateToTheCloud];
    [REDStaticData craateStaticData];
    
    REDBookListViewController *bookList = [[REDBookListViewController alloc] init];
    REDRecommendedBooksViewController *reccomendedBooks = [[REDRecommendedBooksViewController alloc] init];
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    [tab setViewControllers:@[[[UINavigationController alloc] initWithRootViewController:bookList],
                              [[UINavigationController alloc] initWithRootViewController:reccomendedBooks]]];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tab;
    self.window.backgroundColor = [UIColor red_redColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
