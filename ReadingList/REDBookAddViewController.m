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
#import "REDEntityCreator.h"
#import "REDCategoryViewController.h"
#import "REDAuthorViewController.h"
#import "REDEntityRemover.h"
#import "REDImageSearchViewController.h"


@interface REDBookAddViewController () <REDBookCategoryCellDelegate, REDBookPagesCellDelegate, REDBookHeaderCellDelegate>

#pragma mark - properties
@property (nonatomic,strong) id<REDBookProtocol> book;
@property (nonatomic,assign) BOOL isEditing;

#pragma mark - ui
@property (nonatomic,strong) REDBookCategoryCell *categoryCell;
@property (nonatomic,strong) REDBookHeaderCell * headerCell;
@property (nonatomic,strong) REDBookPagesCell * pagesCell;
@property (nonatomic,strong) REDPageProgressCell *progressCell;
@property (nonatomic,  weak) IBOutlet UIStaticTableView *tableView;

@end

@implementation REDBookAddViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.book = (id<REDBookProtocol>)[REDEntityCreator newEntityWithProtocol:@protocol(REDBookProtocol)];
        self.isEditing = NO;
    } return self;
}
-(instancetype)initWithBook:(id<REDBookProtocol>)book {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.book = book;
        self.isEditing = YES;
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
    
    self.headerCell = [[REDBookHeaderCell alloc] init];
    self.headerCell.delegate = self;
    [self.tableView addCell:self.headerCell onSection:section];
    
    self.categoryCell = [[REDBookCategoryCell alloc] init];
    self.categoryCell.delegate = self;
    [self.tableView addCell:self.categoryCell onSection:section];
    
    self.pagesCell = [[REDBookPagesCell alloc] init];
    self.pagesCell.delegate = self;
    [self.tableView addCell:self.pagesCell onSection:section];
    
    self.progressCell = [[REDPageProgressCell alloc] init];
    [self.tableView addCell:self.progressCell onSection:section];
    
    [self.tableView addSection:section];
}

#pragma mark - process book
-(BOOL)processBook {
    NSError *error;
    NSArray *chainOfResponsilbiity = @[self.categoryCell, self.headerCell, self.pagesCell, self.progressCell];
    for (id<REDBookCreationChainProtocol> processor in chainOfResponsilbiity) {
        [processor setNewValuesOnBook:self.book error:&error];
        if (error) {
            NSLog(@"%@",error);
            return NO;
        }
    }
    return YES;
}

#pragma mark - cell delegates
-(void)didSelectCategoryCell:(REDBookCategoryCell *)cell {
    REDCategoryViewController *categories = [[REDCategoryViewController alloc] init];
    categories.callback = ^(id<REDCategoryProtocol> category){
        [self.categoryCell setCategory:category];
    };
    [self.navigationController pushViewController:categories animated:YES];
}
-(void)didSelectCoverInBookHeaderCell:(REDBookHeaderCell *)headerCell {
    REDImageSearchViewController *imageSearchViewController = [[REDImageSearchViewController alloc] init];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:imageSearchViewController] animated:YES completion:nil];
    
}
-(void)didSelectAuthorInBookHeaderCell:(REDBookHeaderCell *)headerCell {
    REDAuthorViewController *authorViewController = [[REDAuthorViewController alloc] init];
    authorViewController.callback = ^(id<REDAuthorProtocol> author) {
        [self.headerCell setAuthor:author];
    };
    [self.navigationController pushViewController:authorViewController animated:YES];
}
-(void)pagesCell:(REDBookPagesCell *)pagesCell didChangeBookPages:(NSUInteger)pages {
    [self.progressCell setPages:pages];
}

#pragma mark - actions
-(void)createAction:(UIBarButtonItem *)createButton {
    BOOL success = [self processBook];
    if (success) [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)cancelAction:(UIBarButtonItem *)cancelAction {
    if (self.isEditing) [REDEntityRemover removeObject:self.book];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}


@end
