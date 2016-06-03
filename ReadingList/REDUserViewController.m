//
//  REDLogViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/24/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDUserViewController.h"
#import "REDNavigationBarCustomizer.h"
#import "REDUserView.h"
#import "REDDatasourceProtocol.h"
#import "REDReadDataAccessObject.h"
#import "REDLogDatasourceDelegate.h"
#import "REDBookAddViewController.h"
#import "REDUserProtocol.h"
#import "REDUserScrollView.h"
#import "REDUserViewDelegate.h"
#import "REDPhotoPickerPresenterProtocol.h"
#import "UIViewController+NotificationShow.h"
#import "REDAddLogViewController.h"
#import "REDNavigationBarCustomizer.h"
#import "UIImage+Blur.h"
#import "REDChartViewController.h"
#import "REDTransactionManager.h"
#import "REDSignUpViewController.h"
#import "REDLogRepositoryFactory.h"
#import "UIViewController+NotificationShow.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDGetUserRequest.h"

@interface REDUserViewController () <REDLogDatasourceDelegate, REDUserViewDelegate, REDSyncViewDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet REDUserScrollView *userScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *blurImageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

#pragma mark - properties
@property (weak, nonatomic) REDChartViewController *chartViewController;

#pragma mark - injected
@property (setter=injected_log:) id<REDDatasourceProtocol> datasource;
@property (setter=injected1:) id<REDReadDataAccessObject> readDataAccessObject;
@property (setter=injected2:) id<REDPhotoPickerPresenterProtocol> photoPicker;
@property (setter=injected3:) id<REDUserProtocol> user;
@property (setter=injected4:) id<REDTransactionManager> transactionManager;
@property (setter=injected5:) id<REDLogRepositoryFactory> logRepositoryFactory;
@property (setter=injected6:) id<REDServiceDispatcherProtocol> serviceDispatcher;

@end

@implementation REDUserViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.tabBarItem.image = [UIImage imageNamed:@"User"];
        self.title = @"You";
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [Localytics tagEvent:@"User Screen"];
    
    //orientation change
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //scroll view
    self.userScrollView.userViewDelegate = self;
    self.userScrollView.syncViewDelegate = self;
    self.userScrollView.user = self.user;
    self.userScrollView.pageControl = self.pageControl;
    
    //blur image
    [self setBlurImageIfExists];
    
    //service
    [self callGetUser];
    
    //datasource
    [self.datasource setDelegate:self];
    [self.tableView setDataSource:self.datasource];
    [self.tableView setDelegate:self.datasource];
    [self.tableView reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.tabBarController.tabBar.hidden = NO;
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar];
    [self updateData];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    [self.navigationItem setRightBarButtonItem:addButton];
    
    UIBarButtonItem *chartButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"chart_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(chartAction:)];
    [self.navigationItem setLeftBarButtonItem:chartButton];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 246);
    self.tableView.tableHeaderView = self.tableView.tableHeaderView; //update height
}

#pragma mark - methods
-(void)updateData {
    [[self.logRepositoryFactory repository] listForUser:self.user callback:^(NSArray<id<REDReadProtocol>> *read) {
        [self.datasource setData:[self.readDataAccessObject logsOrderedByDate]];
    } error:^(NSError *error) {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:error.localizedDescription];
    }];
    [self.tableView reloadData];
}
-(void)setBlurImageIfExists {
    self.blurImageView.image = [self.user hasPhoto] ? [self.user cover]: nil;
}

#pragma mark - orientation
-(void)orientationChanged:(NSNotification *)ntif {
    if ([self.navigationController.topViewController isEqual:self]) {
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if (UIInterfaceOrientationIsLandscape(orientation)) {
            REDChartViewController *chartViewController = [[REDChartViewController alloc] init];
            [self.navigationController pushViewController:chartViewController animated:NO];
            self.chartViewController = chartViewController;
        } else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    if (self.tabBarController.selectedIndex != 2) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - delegates
-(void)datasource:(id<REDDatasourceProtocol>)datasource didDeleteRead:(id<REDReadProtocol>)read {
    [[self.logRepositoryFactory repository] removeForUser:self.user log:read callback:^(id<REDReadProtocol> read) {
        [self.userScrollView updateData];
        [self.datasource setData:[self.readDataAccessObject logsOrderedByDate]];
    } error:^(NSError *error) {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:error.localizedDescription];
    }];
    [self.datasource setData:[self.readDataAccessObject logsOrderedByDate]];
}
-(void)datasource:(id<REDDatasourceProtocol>)datasource wantsToCheckOutBook:(id<REDBookProtocol>)book {
    REDBookAddViewController *bookViewController = [[REDBookAddViewController alloc] initWithBook:book];
    [self.navigationController pushViewController:bookViewController animated:YES];
}
-(BOOL)datasourceCanDeleteLogs:(id<REDDatasourceProtocol>)datasource {
    return YES;
}
-(void)userViewWantsToSelectProfilePhoto:(REDUserView *)userView {
    __weak typeof(self) welf = self;
    [self.photoPicker pickPhotoFromViewController:self hasPhoto:[self.user hasPhoto] withCallback:^(UIImage *image, NSError *error) {
        if (error) {
            [self showNotificationWithType:SHNotificationViewTypeError withMessage:[error localizedDescription]];
        } else {
            [welf.transactionManager begin];
            [welf.user setPhoto:image];
            [welf.userScrollView setUser:welf.user];
            [welf setBlurImageIfExists];
            [welf.transactionManager commit];
        }
    }];
}
-(void)syncViewWantsToAuthenticateWithView:(REDSyncView *)syncView {
    if ([self.user isSyncable] == NO) {
        REDSignUpViewController * signIn = [[REDSignUpViewController alloc] init];
        [self presentViewController:signIn animated:YES completion:nil];
    }
}

#pragma mark - actions
-(void)addAction:(UIBarButtonItem *)addButton {
    REDAddLogViewController *addLog = [[REDAddLogViewController alloc] init];
    [self.navigationController pushViewController:addLog animated:YES];
}
-(void)chartAction:(UIBarButtonItem *)chartButton {
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}

#pragma mark - service
-(void)callGetUser {
    if ([self.user isSyncable]) {
        REDGetUserRequest *request = [[REDGetUserRequest alloc] initWithUserId:[self.user userId]];
        [self.serviceDispatcher callWithRequest:request withTarget:self andSelector:@selector(response:)];
    }
}
-(void)response:(NSNotification *)notif {
    
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}

@end
