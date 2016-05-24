//
//  AppDelegate.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "AppDelegate.h"
#import "REDLibraryViewController.h"
#import "REDDepedencyInjection.h"
#import "Depend/DPInjector.h"
#import "REDStaticData.h"
#import "UIColor+ReadingList.h"
#import "REDDataStack.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "REDExploreViewController.h"
#import "REDLocalMigrationHandler.h"
#import "REDUserViewController.h"
#import "REDLocalToRealm.h"
#import "RFRateMe.h"
#import <DigitsKit/DigitsKit.h>
#import "REDRealmMigrationV2.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDSyncingLoadingView.h"
#import "REDReadDataAccessObject.h"
#import "REDListBooksRequest.h"
#import "REDUserProtocol.h"
#import "REDListLogsRequest.h"
#import "REDBookDataAccessObject.h"

@interface AppDelegate ()

#pragma mark - ui
@property (nonatomic,weak) REDSyncingLoadingView * loadingView;

@property (setter=injected7:) id<REDRealmMigration> migration;
@property (setter=injected3:) id<REDUserProtocol> user;
@property (setter=injected1:) id<REDServiceDispatcherProtocol> serviceDispatcher;
@property (setter=injected2:) id<REDReadDataAccessObject> r;
@property (setter=injected4:) id<REDTransactionManager> transactionManager;
@property (setter=injected5:) id<REDBookDataAccessObject> bookDataAccessObject;
@property (setter=injected6:) id<REDReadDataAccessObject> readDataAccessObject;

@end

@implementation AppDelegate

#pragma mark - Application Delegate
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[Digits sharedInstance] startWithConsumerKey:@"cRLPjIa9kGBICfKpm4bqOUkmh" consumerSecret:@"83f4R5asuM46RubjExlLXLJLnKqoL5n30RNDl3PmoE6Yy8RK98"];
    [Fabric with:@[[Crashlytics class], [Digits class]]];
    self.migration = [[REDRealmMigrationV2 alloc] init];
    [self.migration migrate];
    [DPInjector inject];
    [REDDepedencyInjection registerImplementations];
    [REDStaticData craateStaticData];
    [RFRateMe showRateAlertAfterTimesOpened:15];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startStatusBarLoading:) name:REDStartStatusBarSyncingLoadingViewNotificationKey object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopStatusBarLoading) name:REDStopStatusBarSyncingLoadingViewNotificationKey object:nil];
    
    REDLibraryViewController *bookList = [[REDLibraryViewController alloc] init];
    REDExploreViewController *reccomendedBooks = [[REDExploreViewController alloc] init];
    REDUserViewController *log = [[REDUserViewController alloc] init];
    
    UITabBarController *tab = [[UITabBarController alloc] init];
    [tab setViewControllers:@[[[UINavigationController alloc] initWithRootViewController:bookList],
                              [[UINavigationController alloc] initWithRootViewController:reccomendedBooks],
                              [[UINavigationController alloc] initWithRootViewController:log]]];
    

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = tab;
    self.window.backgroundColor = [UIColor colorWithWhite:.98 alpha:1];
    [self.window makeKeyAndVisible];
    
    [self changes];
    
    return YES;
}

-(void)applicationDidBecomeActive:(UIApplication *)application {
    [self.serviceDispatcher processUnprocessedRequestIfNeeded];
}

-(void)changes {
    [self.transactionManager begin];
    for (id<REDReadProtocol> read in [self.readDataAccessObject logsOrderedByDate]) {
        if ([read uuid] == nil) [read setUuid:[[NSUUID UUID] UUIDString]];
    }
    [self.transactionManager commit];
}

#pragma mark - loading
-(void)startStatusBarLoading:(NSNotification *)notification {
    if (!self.loadingView && [[notification object] isTransactionRequest]) {
        REDSyncingLoadingView * loadignView = [[REDSyncingLoadingView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 25)];
        self.window.windowLevel = UIWindowLevelStatusBar + 1;
        [self setLoadingView:loadignView];
        [self.window addSubview:self.loadingView];
        [self.window bringSubviewToFront:loadignView];
    }
}
-(void)stopStatusBarLoading {
    self.window.windowLevel = UIWindowLevelStatusBar - 1;
    [self.loadingView removeFromSuperview];
    self.loadingView = nil;
}


@end
