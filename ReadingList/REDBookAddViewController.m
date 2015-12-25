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
#import "REDDataStack.h"
#import "UIViewController+NotificationShow.h"
#import "REDRandomQuoteGenerator.h"
#import <Crashlytics/Answers.h>

@interface REDBookAddViewController () <REDBookCategoryCellDelegate, REDBookPagesCellDelegate, REDBookHeaderCellDelegate, REDPageProgressCellDelegate>

#pragma mark - properties
@property (nonatomic,strong) id<REDBookProtocol> book;
@property (nonatomic,assign) BOOL isEditing;

#pragma mark - ui
@property (nonatomic,strong) REDBookCategoryCell *categoryCell;
@property (nonatomic,strong) REDBookHeaderCell * headerCell;
@property (nonatomic,strong) REDBookPagesCell * pagesCell;
@property (nonatomic,strong) REDPageProgressCell *progressCell;
@property (nonatomic,  weak) IBOutlet UIStaticTableView *tableView;
@property (nonatomic,  weak) IBOutlet UILabel *quoteLabel;

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
    self.title = self.isEditing ? @"Edit Book" : @"New Book";
    [self createTableView];
    [self setUpBarButtonItems];
    [self.quoteLabel setText:[REDRandomQuoteGenerator quote]];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar];

}
-(void)viewWillDisappear:(BOOL)animated {
    if (self.isMovingFromParentViewController) {
        NSError * error;
        if ([self processBook:&error] == NO && !self.isEditing) {
            [REDEntityRemover removeObject:self.book];
        } else {
            [[REDDataStack sharedManager] commit];
        }
    }
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!self.isEditing) [self.headerCell.nameTextField becomeFirstResponder];
}

#pragma mark - setups
-(void)setUpBarButtonItems {
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
}

#pragma mark - table view
-(void)createTableView {
    UIStaticTableViewSection * section = [[UIStaticTableViewSection alloc] init];
    [section setHeaderName:@"Book Info"];
    
    self.headerCell = [[REDBookHeaderCell alloc] init];
    [self.headerCell setBook:self.book];
    self.headerCell.delegate = self;
    [self.tableView addCell:self.headerCell onSection:section];
    
    self.categoryCell = [[REDBookCategoryCell alloc] init];
    [self.categoryCell setCategory:[self.book category]];
    self.categoryCell.delegate = self;
    [self.tableView addCell:self.categoryCell onSection:section];
    
    self.pagesCell = [[REDBookPagesCell alloc] init];
    [self.pagesCell setPages:[[self book] pagesValue]];
    self.pagesCell.delegate = self;
    [self.tableView addCell:self.pagesCell onSection:section];
    
    self.progressCell = [[REDPageProgressCell alloc] init];
    [self.progressCell setBook:self.book];
    [self.progressCell setDelegate:self];
    [self.progressCell setPages:[self.book pagesValue]];
    [self.tableView addCell:self.progressCell onSection:section];
    
    [self.tableView addSection:section];
}

#pragma mark - process book
-(BOOL)processBook:(NSError * _Nullable __autoreleasing *)error {
    NSArray *chainOfResponsilbiity = @[self.categoryCell, self.headerCell, self.pagesCell, self.progressCell];
    for (id<REDBookCreationChainProtocol> processor in chainOfResponsilbiity) {
        [processor setNewValuesOnBook:self.book error:error];
        if (*error) {
            return NO;
        }
    }
    [[REDDataStack sharedManager] commit];
    return YES;
}
-(BOOL)finishBook {
    NSError *error;
    BOOL success = [self processBook:&error];
    if (success) [self.navigationController popViewControllerAnimated:YES];
    else {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:error.localizedDescription];
    }
    return success;
}

#pragma mark - cell delegates
-(void)didSelectCategoryCell:(REDBookCategoryCell *)cell {
    __weak typeof(self) welf = self;
    REDCategoryViewController *categories = [[REDCategoryViewController alloc] init];
    categories.callback = ^(id<REDCategoryProtocol> category){
        [welf.categoryCell setCategory:category];
    };
    [self.navigationController pushViewController:categories animated:YES];
}
-(void)didSelectCoverInBookHeaderCell:(REDBookHeaderCell *)headerCell {
    if (self.headerCell.nameTextField.text.length == 0) {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:@"Set the book name to find a cover"];
        return;
    }
    REDImageSearchViewController *imageSearchViewController = [[REDImageSearchViewController alloc] initWithBookName:headerCell.nameTextField.text andAuthor:headerCell.authorButton.currentTitle];
    imageSearchViewController.callback = ^(UIImage *image) {
        [headerCell setCoverImage:image];
    };
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:imageSearchViewController] animated:YES completion:nil];
    
}
-(void)didSelectAuthorInBookHeaderCell:(REDBookHeaderCell *)headerCell {
    REDAuthorViewController *authorViewController = [[REDAuthorViewController alloc] init];
    authorViewController.callback = ^(id<REDAuthorProtocol> author) {
        [headerCell setAuthor:author];
    };
    [self.navigationController pushViewController:authorViewController animated:YES];
}
-(void)pagesCell:(REDBookPagesCell *)pagesCell didChangeBookPages:(NSUInteger)pages {
    [self.progressCell setPages:pages];
}
-(void)pageProgressCell:(REDPageProgressCell *)cell tryingToSetPagesWhileIsZeroForBook:(id<REDBookProtocol>)book {
    [self showNotificationWithType:SHNotificationViewTypeError withMessage:@"Set the pages before reading it!"];
}

#pragma mark - actions
-(void)doneAction:(UIBarButtonItem *)createButton {
    if ([self finishBook]) {
        [self.navigationController popViewControllerAnimated:YES];
        [[REDDataStack sharedManager] commit];
        if (self.isEditing) {
            [Answers logContentViewWithName:@"Book"
                                contentType:@"Viewing"
                                  contentId:@""
                           customAttributes:@{}];
        } else {
            [Answers logContentViewWithName:@"Book"
                                contentType:@"Adding"
                                  contentId:@""
                           customAttributes:@{}];
        }
    }
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    NSLog(@"DEALLOC");
}


@end
