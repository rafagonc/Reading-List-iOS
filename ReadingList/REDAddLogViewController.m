//
//  REDAddLogViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/26/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDAddLogViewController.h"
#import "UIStaticTableView.h"
#import "REDBookDataAccessObject.h"
#import "REDNavigationBarCustomizer.h"
#import "REDChooseBookCell.h"
#import "REDPagesReadCell.h"
#import "REDChooseDateCell.h"
#import "REDChooseBookViewController.h"
#import "REDLogCreateChainProtocol.h"
#import "REDReadDataAccessObject.h"
#import "UIViewController+NotificationShow.h"
#import "REDDataStack.h"

@interface REDAddLogViewController () <REDChooseBookCellDelegate, REDChooseBookViewControllerDelegate, REDLogCreateChainProtocol>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIStaticTableView *tableView;
@property (weak, nonatomic) REDChooseBookCell *chooseBookCell;

#pragma mark - properties
@property (nonatomic,strong) NSHashTable *processors;
@property (nonatomic,strong) id<REDReadProtocol> read;

#pragma mark - injected
@property (setter=injected:,readonly) id<REDReadDataAccessObject> readDataAccessObject;

@end

@implementation REDAddLogViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.title = @"Add Reading Log";
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.processors = [NSHashTable hashTableWithOptions:NSPointerFunctionsWeakMemory];
    
    [self createTableView];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar];
    
    UIBarButtonItem *createButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    [self.navigationItem setRightBarButtonItem:createButton];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

#pragma mark - table view
-(void)createTableView {
    UIStaticTableViewSection *section = [[UIStaticTableViewSection alloc] init];
    
    REDChooseBookCell * chooseBookCell = [[REDChooseBookCell alloc] init];
    chooseBookCell.delegate = self;
    [self.tableView addCell:chooseBookCell onSection:section];
    self.chooseBookCell = chooseBookCell;
    [self.processors addObject:chooseBookCell];
    
    REDPagesReadCell *pagesReadCell = [[REDPagesReadCell alloc] init];
    [self.tableView addCell:pagesReadCell onSection:section];
    [self.processors addObject:pagesReadCell];

    REDChooseDateCell *chooseDateCell = [[REDChooseDateCell alloc] init];
    [self.tableView addCell:chooseDateCell onSection:section];
    [self.processors addObject:chooseDateCell];
    
    [self.tableView addSection:section];
}

#pragma mark - delagate
-(void)chooseBookCellWantsToChooseBook:(REDChooseBookCell *)cell {
    REDChooseBookViewController *viewController = [[REDChooseBookViewController alloc] init];
    viewController.delegate = self;
    [self.navigationController pushViewController:viewController animated:YES];
}
-(void)chooseBookViewController:(REDChooseBookViewController *)chooseBookViewController justChoseBook:(id<REDBookProtocol>)book {
    self.chooseBookCell.book = book;
}

#pragma mark - chain of responsibility
-(BOOL)process:(id<REDReadProtocol>)read error:(NSError *__autoreleasing *)error {
    NSArray *processorsArray = [self.processors allObjects];
    for (id<REDLogCreateChainProtocol> chainObject in processorsArray) {
        if (![chainObject process:read error:error]) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - action
-(void)doneAction:(UIBarButtonItem *)item {
    NSError *error;
    self.read = [self.readDataAccessObject create];
    if (![self process:self.read error:&error]) {
        [self.readDataAccessObject remove:self.read];
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:[error localizedDescription]];
        return;
    }
    [[REDDataStack sharedManager] commit];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cancelAction:(UIBarButtonItem *)item {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}

@end
