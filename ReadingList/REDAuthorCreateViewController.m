//
//  REDAuthorCreateViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/15/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDAuthorCreateViewController.h"
#import "UIStaticTableView.h"
#import "REDUITextFieldCell.h"
#import "REDDataStack.h"
#import "REDNavigationBarCustomizer.h"
#import "REDAuthorDataAccessObject.h"
#import "REDAuthorProtocol.h"
#import "UIViewController+NotificationShow.h"
#import "REDTransactionManager.h"
#import "REDValidator.h"

@interface REDAuthorCreateViewController ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIStaticTableView *tableView;
@property (strong, nonatomic) REDUITextFieldCell *authorNameCell;

#pragma mark - injected
@property (setter=injected1:) id<REDAuthorDataAccessObject> authorDataAccessObject;
@property (setter=injected2:) id<REDTransactionManager> transactionManager;
@property (setter=injected_authorName:,readonly) id<REDValidator> authorNameValidator;

@end

@implementation REDAuthorCreateViewController

#pragma mark - init
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Create Author";
    
    [self setUpBarButtonsItems];
    [self createTableview];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.authorNameCell.textField becomeFirstResponder];
}

#pragma mark - setup
-(void)setUpBarButtonsItems {
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithTitle:@"Create" style:UIBarButtonItemStylePlain target:self action:@selector(createAction:)];
    [self.navigationItem setRightBarButtonItem:createButton];
}

#pragma mark - create table view
-(void)createTableview {
    UIStaticTableViewSection *section = [[UIStaticTableViewSection alloc] init];
    [section setHeaderName:@"Author's Name"];

    self.authorNameCell = [[REDUITextFieldCell alloc] init];
    [self.tableView addCell:self.authorNameCell onSection:section];
    
    [self.tableView addSection:section];
}

#pragma mark - actions
-(void)cancelAction:(UIBarButtonItem *)item {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)createAction:(UIBarButtonItem *)item {
    if ([self isValid]) {
        id<REDAuthorProtocol> author = [self.authorDataAccessObject create];
        [self.transactionManager begin];
        [author setName:self.authorNameCell.textField.text];
        [self.transactionManager commit];
        [self dismissViewControllerAnimated:YES completion:nil];
        if (self.callback) self.callback(author);
        self.callback = nil;
    }
}

#pragma mark - validation
-(BOOL)isValid {
    NSError *error;
    if (![self.authorNameValidator validate:self.authorNameCell.textField.text error:&error]) {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:error.localizedDescription];
        return NO;
    }
    return YES;
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}


@end
