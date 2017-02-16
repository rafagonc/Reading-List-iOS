//
//  REDCategoryCreateViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 8/13/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDCategoryCreateViewController.h"
#import "UIStaticTableView.h"
#import "REDUITextFieldCell.h"
#import "REDNavigationBarCustomizer.h"
#import "REDCategoryDataAccessObject.h"
#import "REDTransactionManager.h"
#import "REDValidator.h"
#import "UIViewController+NotificationShow.h"

@interface REDCategoryCreateViewController ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIStaticTableView *tableView;
@property (weak, nonatomic) REDUITextFieldCell * nameCell;

#pragma mark - properties
@property (nonatomic,strong) id<REDCategoryProtocol> category;

#pragma mark - injected
@property (setter=injected1:) id<REDCategoryDataAccessObject> categoryDataAccessObject;
@property (setter=injected2:) id<REDTransactionManager> transactionManager;
@property (setter=injected_categoryName:) id<REDValidator> validator;

@end

@implementation REDCategoryCreateViewController

#pragma mark  - constructor
-(instancetype)init {
    if (self = [super init]) {
        self.title = @"Create Category";
    } return self;
}
-(instancetype)initWithCategory:(id<REDCategoryProtocol>)category {
    if (self = [super init]) {
        self.category = category;
        self.title = @"Edit Category";
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [self setUpBarButtonsItems];
    [self createTableView];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.nameCell.textField becomeFirstResponder];
}

#pragma mark - setup
-(void)setUpBarButtonsItems {
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithTitle:self.category ? @"Edit" : @"Create" style:UIBarButtonItemStylePlain target:self action:@selector(createAction:)];
    [self.navigationItem setRightBarButtonItem:createButton];
}

#pragma mark - table view
-(void)createTableView {
    UIStaticTableViewSection * section = [[UIStaticTableViewSection alloc] init];
    [section setHeaderName:@"Category Name"];
    
    REDUITextFieldCell * nameCell = [[REDUITextFieldCell alloc] init];
    [nameCell.textField setText:[self.category name]];
    [self.tableView addCell:nameCell onSection:section];
    [self setNameCell:nameCell];
    
    [self.tableView addSection:section];
}

#pragma mark - action
-(void)cancelAction:(UIBarButtonItem *)item {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)createAction:(UIBarButtonItem *)item {
    NSError * error;
    if ([self.validator validate:self.nameCell.textField.text error:&error] == NO) {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:error.localizedDescription];
        return;
    }
    
    id<REDCategoryProtocol> category = self.category ? self.category : [self.categoryDataAccessObject create];
    [self.transactionManager begin];
    [category setCustom:YES];
    [category setName:[[self.nameCell textField] text]];
    [self.transactionManager commit];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - dealloc
-(void)dealloc {
    
}

@end
