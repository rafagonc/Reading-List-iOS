//
//  REDLogViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/24/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLogViewController.h"
#import "REDNavigationBarCustomizer.h"
#import "REDUserView.h"
#import "REDDatasourceProtocol.h"
#import "REDReadDataAccessObject.h"
#import "REDLogDatasourceDelegate.h"
#import "REDBookAddViewController.h"

@interface REDLogViewController () <REDLogDatasourceDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) REDUserView *userView;

#pragma mark - injected
@property (setter=injected_log:,readonly) id<REDDatasourceProtocol> datasource;
@property (setter=injected:,readonly) id<REDReadDataAccessObject> readDataAccessObject;

@end

@implementation REDLogViewController

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
    
    //datasource
    [self.datasource setData:[self.readDataAccessObject logsOrderedByDate]];
    [self.datasource setDelegate:self];
    [self.tableView setDataSource:self.datasource];
    [self.tableView setDelegate:self.datasource];
    [self.tableView reloadData];
    
    //retain user view
    REDUserView *userView = [[REDUserView alloc] init];
    self.tableView.tableHeaderView = userView;
    self.userView = userView;
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, self.view.frame.size.width, 240);
    self.tableView.tableHeaderView = self.tableView.tableHeaderView; //update height
}

#pragma mark - datasource
-(void)datasource:(id<REDDatasourceProtocol>)datasource wantsToCheckOutBook:(id<REDBookProtocol>)book {
    REDBookAddViewController *bookAdd = [[REDBookAddViewController alloc] initWithBook:book];
    [self.navigationController pushViewController:bookAdd animated:YES];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}

@end
