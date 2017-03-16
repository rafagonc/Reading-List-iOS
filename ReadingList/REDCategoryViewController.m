//
//  REDCategoryViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/14/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDCategoryViewController.h"
#import "REDDatasourceProtocol.h"
#import "REDCategoryDataAccessObject.h"
#import "REDCategoryCreateViewController.h"
#import "REDCategoryDatasourceDelegate.h"
#import "REDCategoryCreateViewController.h"

@interface REDCategoryViewController () <UITableViewDelegate, REDCategoryDatasourceDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITableView *tableView;

#pragma mark - injected
@property (setter=injected_category:) id<REDDatasourceProtocol> datasource;
@property (setter=injected:) id<REDCategoryDataAccessObject> categoryDataAccessObject;

@end

@implementation REDCategoryViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Choose Category";
    
    [Localytics tagScreen:self.title];
    
    [self.datasource setDelegate:self];
    self.tableView.dataSource = self.datasource;
    self.tableView.delegate = self.datasource;
    
    [self updateData];
    [self setupBarButtonItems];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateData];
}

#pragma mark - setups
-(void)setupBarButtonItems {
    UIBarButtonItem * addCategory = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCategoryAction:)];
    [self.navigationItem setRightBarButtonItem:addCategory];
}

#pragma mark - methods
-(void)updateData {
    [self.datasource setData:[self.categoryDataAccessObject categoriesSortedByName]];
}

#pragma mark - table view delegate
-(void)categoryDatasource:(id<REDDatasourceProtocol>)datasource didSelectCategory:(id<REDCategoryProtocol>)category {
    if (self.callback) self.callback(category);
    self.callback = nil;
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)categoryDatasource:(id<REDDatasourceProtocol>)datasource wantsToEditCategory:(id<REDCategoryProtocol>)category {
    REDCategoryCreateViewController * createViewController = [[REDCategoryCreateViewController alloc] initWithCategory:category];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:createViewController] animated:YES completion:nil];
}

#pragma mark - action
-(void)addCategoryAction:(UIBarButtonItem *)item {
    REDCategoryCreateViewController * vc = [[REDCategoryCreateViewController alloc] init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}

@end
