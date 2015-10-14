//
//  REDBookAddViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookAddViewController.h"
#import "UIStaticTableView.h"
#import "REDNavigationBarCustomizer.h"
#import "REDBookHeaderCell.h"
#import "REDBookCategoryCell.h"
#import "REDBookPagesCell.h"
#import "REDPageProgressCell.h"

@interface REDBookAddViewController ()

#pragma mark - properties
@property (weak, nonatomic) IBOutlet UIStaticTableView *tableView;

@end

@implementation REDBookAddViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"New Book";
    [self createTableView];
    [self setUpBarButtonItems];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar];
}

#pragma mark - setups
-(void)setUpBarButtonItems {
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Create" style:UIBarButtonItemStyleDone target:self action:@selector(createAction:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
    
    UIBarButtonItem * cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    
}

#pragma mark - table view
-(void)createTableView {
    UIStaticTableViewSection * section = [[UIStaticTableViewSection alloc] init];
    [section setHeaderName:@"Book Info"];
    
    REDBookHeaderCell *headerCell = [[REDBookHeaderCell alloc] init];
    [self.tableView addCell:headerCell onSection:section];
    
    REDBookCategoryCell *categoryCell = [[REDBookCategoryCell alloc] init];
    [self.tableView addCell:categoryCell onSection:section];
    
    REDBookPagesCell *pagesCell = [[REDBookPagesCell alloc] init];
    [self.tableView addCell:pagesCell onSection:section];
    
    REDPageProgressCell *progressCell = [[REDPageProgressCell alloc] init];
    [self.tableView addCell:progressCell onSection:section];
    
    [self.tableView addSection:section];
}

#pragma mark - actions
-(void)createAction:(UIBarButtonItem *)createButton {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)cancelAction:(UIBarButtonItem *)cancelAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}


@end