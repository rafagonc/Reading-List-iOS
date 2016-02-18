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

@interface REDUserViewController () <REDLogDatasourceDelegate, REDUserViewDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet REDUserScrollView *userScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *blurImageView;
@property (weak, nonatomic) REDChartViewController *chartViewController;

#pragma mark - injected
@property (setter=injected_log:,readonly) id<REDDatasourceProtocol> datasource;
@property (setter=injected:,readonly) id<REDReadDataAccessObject> readDataAccessObject;
@property (setter=injected:,readonly) id<REDPhotoPickerPresenterProtocol> photoPicker;
@property (setter=injected:,readonly) id<REDUserProtocol> user;
@property (setter=injected:,readonly) id<REDTransactionManager> transactionManager;

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
    
    //orientation change
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    //scroll view
    self.userScrollView.userViewDelegate = self;
    self.userScrollView.user = self.user;
    
    //blur image
    [self setBlurImageIfExists];
    
    //datasource
    [self.datasource setData:[self.readDataAccessObject logsOrderedByDate]];
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
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 190);
    self.tableView.tableHeaderView = self.tableView.tableHeaderView; //update height
    [self updateData];
}

#pragma mark - methods
-(void)updateData {
    [self.datasource setData:[self.readDataAccessObject logsOrderedByDate]];
    [self.tableView reloadData];
}
-(void)setBlurImageIfExists {
    self.blurImageView.image = [self.user hasPhoto] ? [self.user cover]: nil;
}

#pragma mark - orientation
-(void)orientationChanged:(NSNotification *)ntif {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        REDChartViewController *chartViewController = [[REDChartViewController alloc] init];
        [self.navigationController pushViewController:chartViewController animated:NO];
        self.chartViewController = chartViewController;
    } else {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

#pragma mark - delegates
-(void)datasource:(id<REDDatasourceProtocol>)datasource didDeleteRead:(id<REDReadProtocol>)read {
    [self.userScrollView updateData];
}
-(void)datasource:(id<REDDatasourceProtocol>)datasource wantsToCheckOutBook:(id<REDBookProtocol>)book {
    REDBookAddViewController *bookAdd = [[REDBookAddViewController alloc] initWithBook:book];
    [self.navigationController pushViewController:bookAdd animated:YES];
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

#pragma mark - actions
-(void)addAction:(UIBarButtonItem *)addButton {
    REDAddLogViewController *addLog = [[REDAddLogViewController alloc] init];
    [self.navigationController pushViewController:addLog animated:YES];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}

@end
