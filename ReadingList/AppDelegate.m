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
#import "REDLocalMigrationHandler.h"
#import "REDUserViewController.h"
#import "REDLocalToRealm.h"
#import "RFRateMe.h"
#import <DigitsKit/DigitsKit.h>
#import "REDRealmMigrationV2.h"

@interface AppDelegate ()

@property (setter=injected:) id<REDRealmMigration> migration;

@end

@implementation AppDelegate

#pragma mark - Application Delegate
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[[Crashlytics class], [Digits class]]];
    self.migration = [[REDRealmMigrationV2 alloc] init];
    [self.migration migrate];
    [DPInjector inject];
    [REDDepedencyInjection registerImplementations];
    [REDStaticData craateStaticData];
    [RFRateMe showRateAlertAfterTimesOpened:15];
    
    REDBookListViewController *bookList = [[REDBookListViewController alloc] init];
    REDRecommendedBooksViewController *reccomendedBooks = [[REDRecommendedBooksViewController alloc] init];
    REDUserViewController *log = [[REDUserViewController alloc] init];
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    [tab setViewControllers:@[[[UINavigationController alloc] initWithRootViewController:bookList],
                              [[UINavigationController alloc] initWithRootViewController:reccomendedBooks],
                              [[UINavigationController alloc] initWithRootViewController:log]]];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tab;
    self.window.backgroundColor = [UIColor colorWithWhite:.98 alpha:1];
    [self.window makeKeyAndVisible];
    
    return YES;
}


@end
