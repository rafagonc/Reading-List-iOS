

//
//  REDBookListViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookListViewController.h"
#import "REDDatasourceProtocol.h"
#import "REDBookProtocol.h"
#import "REDEntityFetcher.h"
#import "REDNavigationBarCustomizer.h"
#import "REDBookAddViewController.h"

@interface REDBookListViewController ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITableView *tableView;

#pragma mark - injected
@property (setter=injected_book:, readonly) id<REDDatasourceProtocol> datasource;

@end

@implementation REDBookListViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Book List";
    
    self.tableView.dataSource = self.datasource;
    
    [self updateData];
    [self setUpBarButtonItems];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar];
}

#pragma mark - setups
-(void)setUpBarButtonItems {
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    [self.navigationItem setRightBarButtonItem:addButton];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction:)];
    [self.navigationItem setLeftBarButtonItem:editButton];
}

#pragma mark - actions
-(void)addAction:(UIBarButtonItem *)addbutton {
    REDBookAddViewController *detailViewController = [[REDBookAddViewController alloc] init]
    ;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:detailViewController] animated:YES completion:nil];
}
-(void)editAction:(UIBarButtonItem *)editAction {
    
}

#pragma mark - methods
-(void)updateData {
    [self.datasource setData:[[REDEntityFetcher withProtocol:@protocol(REDBookProtocol)] all]];
}

@end
