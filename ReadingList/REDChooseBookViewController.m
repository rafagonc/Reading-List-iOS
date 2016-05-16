//
//  REDChooseBookViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/27/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDChooseBookViewController.h"
#import "REDDatasourceProtocol.h"
#import "REDBookDataAccessObject.h"
#import "REDBookDatasourceDelegate.h"

@interface REDChooseBookViewController () <REDBookDatasourceDelegate>

#pragma mark - ui
@property (nonatomic, weak) IBOutlet UITableView *tableView;

#pragma mark - injected
@property (setter=injected_book:) id<REDDatasourceProtocol> datasource;
@property (setter=injected:) id<REDBookDataAccessObject> bookDataAccessObject;

@end

@implementation REDChooseBookViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.title = @"Choose Book";
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.datasource setData:[self.bookDataAccessObject allBooksSorted]];
    [self.datasource setDelegate:self];
    [self.tableView setDataSource:self.datasource];
    [self.tableView setDelegate:self.datasource];
    [self.tableView reloadData];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - delegate
-(void)datasource:(id<REDDatasourceProtocol>)datasource didSelectBook:(id<REDBookProtocol>)book {
    [self.delegate chooseBookViewController:self justChoseBook:book];
    [self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)datasourceCanEditBooks:(id<REDDatasourceProtocol>)datasource {
    return NO;
}
-(BOOL)datasourceShouldShowAccessoryType:(id<REDDatasourceProtocol>)datasource {
    return NO;
}

#pragma mark - daelloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}

@end
