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
#import "REDCategoryViewController.h"
#import "REDAuthorViewController.h"
#import "REDImageSearchViewController.h"
#import "REDDataStack.h"
#import "UIViewController+NotificationShow.h"
#import "REDRandomQuoteGenerator.h"
#import <Crashlytics/Answers.h>
#import "REDTransientBook.h"
#import "REDBookDataAccessObject.h"
#import "REDGoogleBooksQueryRequest.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDServiceResponse.h"
#import "REDValidator.h"
#import "REDCloudDataStack.h"
#import "REDBookUploaderProtocol.h"
#import "REDReadFactoryProtocol.h"
#import "REDTopRatedBook.h"
#import "REDPleaseRateViewController.h"
#import "REDBookRepositoryFactory.h"
#import "REDUserProtocol.h"

typedef NS_ENUM(NSUInteger, REDBookAddViewControllerActionType) {
    REDBookAddViewControllerActionTypeAdding,
    REDBookAddViewControllerActionTypeEditing,
    REDBookAddViewControllerActionTypeTransientBook,
};

@interface REDBookAddViewController ()

<REDBookCategoryCellDelegate, REDBookPagesCellDelegate, REDBookHeaderCellDelegate, REDPageProgressCellDelegate>

#pragma mark - properties
@property (nonatomic,strong) id<REDBookProtocol> book;
@property (nonatomic,strong) id<REDBookProtocol> transientBook;
@property (nonatomic,assign) REDBookAddViewControllerActionType actionType;

#pragma mark - ui
@property (nonatomic,strong) REDBookCategoryCell *categoryCell;
@property (nonatomic,strong) REDBookHeaderCell * headerCell;
@property (nonatomic,strong) REDBookPagesCell * pagesCell;
@property (nonatomic,strong) REDPageProgressCell *progressCell;
@property (nonatomic,  weak) IBOutlet UIStaticTableView *tableView;
@property (nonatomic,  weak) IBOutlet UILabel *quoteLabel;

#pragma mark - injected
@property (setter=injected_name:) id<REDValidator> bookNameValidator;
@property (setter=injected_author:) id<REDValidator> authorValidator;
@property (setter=injected1:) id<REDUserProtocol> user;
@property (setter=injected2:) id<REDBookUploaderProtocol> bookUploader;
@property (setter=injected3:) id<REDBookRepositoryFactory> bookRepositoryFactory;
@property (setter=injected4:) id<REDTransactionManager> transactionManager;
@property (setter=injected5:) id<REDReadFactoryProtocol> readFactory;;
@property (setter=injected6:) id<REDBookDataAccessObject> bookDataAccessObject;
@property (setter=injected7:) id<REDServiceDispatcherProtocol> serviceDispatcher;

@end

@implementation REDBookAddViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.book = [self.bookDataAccessObject create];
        self.actionType = REDBookAddViewControllerActionTypeAdding;
    } return self;
}
-(instancetype)initWithBook:(id<REDBookProtocol>)book {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        if ([book isKindOfClass:[REDTransientBook class]] || [book conformsToProtocol:@protocol(REDTopRatedBook)]) {
            self.book = [self.bookDataAccessObject create];
            self.actionType = REDBookAddViewControllerActionTypeTransientBook;
            self.transientBook = book;
        } else {
            self.book = book;
            self.actionType = REDBookAddViewControllerActionTypeEditing;
        }
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.actionType == REDBookAddViewControllerActionTypeAdding || self.actionType == REDBookAddViewControllerActionTypeTransientBook ? @"New Book" : @"Edit Book";
    [self createTableView];
    if ([self.book snippet].length == 0 && self.actionType == REDBookAddViewControllerActionTypeEditing) [self callServiceForBookDescription];
    [self setUpBarButtonItems];
    [self.quoteLabel setText:[REDRandomQuoteGenerator quote]];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.actionType == REDBookAddViewControllerActionTypeAdding) {
        [self.headerCell.nameTextField becomeFirstResponder];
    }
}

#pragma mark - setups
-(void)setUpBarButtonItems {
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
    
    UIBarButtonItem * cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction:)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
}

#pragma mark - table view
-(void)createTableView {
    UIStaticTableViewSection * section = [[UIStaticTableViewSection alloc] init];
    
    self.headerCell = [[REDBookHeaderCell alloc] init];
    [self.headerCell setBook:self.actionType == REDBookAddViewControllerActionTypeTransientBook ? self.transientBook : self.book];
    [self.headerCell setSnippet:self.actionType == REDBookAddViewControllerActionTypeTransientBook ? [self.transientBook snippet] :[self.book snippet]];
    [self.headerCell setCoverURL:self.actionType == REDBookAddViewControllerActionTypeTransientBook ? [self.transientBook coverURL] : [self.book coverURL]];
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
-(void)processBookWithCallback:(void(^)(BOOL success, NSError * out_error))callback {
    [self.transactionManager begin];
    NSArray *chainOfResponsilbiity = @[self.categoryCell, self.headerCell, self.pagesCell, self.progressCell];
    NSError *error;
    for (id<REDBookCreationChainProtocol> processor in chainOfResponsilbiity) {
        [processor setNewValuesOnBook:self.book error:&error];
        if (error) {
            [self.transactionManager commit];
            callback(NO, error);
            return;
        }
    }
    if (self.actionType == REDBookAddViewControllerActionTypeAdding || self.actionType == REDBookAddViewControllerActionTypeTransientBook) {
        [[self.bookRepositoryFactory repository] createForUser:self.user book:self.book callback:^(id<REDBookProtocol> createdBook) {
            callback(YES,nil);
        } error:^(NSError *error) {
            callback(NO,error);
        }];
    } else {
        [[self.bookRepositoryFactory repository] updateForUser:self.user book:self.book callback:^(id<REDBookProtocol> createdBook) {
            callback(YES,nil);
        } error:^(NSError *error) {
            callback(NO, error);
        }];
    }
}
-(void)finishBookWithSuccessCallback:(void(^)())callback {
    [self processBookWithCallback:^(BOOL success, NSError *out_error) {
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
            [self uploadRatingIfChanged];
            callback();
        } else {
            [self showNotificationWithType:SHNotificationViewTypeError withMessage:out_error.localizedDescription];
        }
    }];
}
-(void)uploadRatingIfChanged {
    if (self.progressCell.didChangeRate) {
        [self.bookUploader uploadBook:self.book forRating:self.progressCell.rating];
    }
}
-(void)savePageChangedIfNeeded {
    if (self.progressCell.diff > 0)[self.readFactory createReadWithPageDiff:self.progressCell.diff forBook:self.book];
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
    NSError *error;
    if (![self.bookNameValidator validate:self.headerCell.nameTextField.text error:&error] || ![self.authorValidator validate:self.headerCell.author error:&error]) {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:[error localizedDescription]];
        return;
    }
    REDImageSearchViewController *imageSearchViewController = [[REDImageSearchViewController alloc] initWithBookName:headerCell.nameTextField.text andAuthor:headerCell.authorButton.currentTitle];
    imageSearchViewController.callback = ^(UIImage *image, NSString *url) {
        [headerCell setCoverImage:image];
        [headerCell setCoverURL:url];
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
-(void)didSelectSnippetTextViewInBookHeaderCell:(REDBookHeaderCell *)headerCell {
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}
-(void)pagesCell:(REDBookPagesCell *)pagesCell didChangeBookPages:(NSUInteger)pages {
    [Localytics tagEvent:@"Page Progress" attributes:@{@"pages" : [NSString stringWithFormat:@"%lu", (unsigned long)pages]}];
    [self.progressCell setPages:pages];
}
-(void)pageProgressCell:(REDPageProgressCell *)cell tryingToSetPagesWhileIsZeroForBook:(id<REDBookProtocol>)book {
    [self showNotificationWithType:SHNotificationViewTypeError withMessage:@"Set the pages before reading it!"];
}
-(void)pageProgressCell:(REDPageProgressCell *)cell didCompleteBookReading:(id<REDBookProtocol>)book {
    [Localytics tagEvent:@"Completed Book" attributes:@{@"pages" : [NSString stringWithFormat:@"%lu", (long)[book pagesValue] ? (long)[book pagesValue] : 0], @"book" : [book name] ? [book name] : [self.transientBook name]}];
    REDPleaseRateViewController *rateViewController = [[REDPleaseRateViewController alloc] initWithBook:self.book];
    [self presentViewController:rateViewController animated:YES completion:nil];
}

#pragma mark - query description
-(void)callServiceForBookDescription {
    [self.headerCell setIsLoading:YES];
    REDGoogleBooksQueryRequest *request = [[REDGoogleBooksQueryRequest alloc] initWithQuery:[NSString stringWithFormat:@"%@ %@",[[self book] name], [[[self book] author] name]]];
    [self.serviceDispatcher callWithRequest:request withTarget:self andSelector:@selector(response:)];
}
-(void)response:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = notification.object;
    if ([response success]) {
        NSString *description = [[[response data] firstObject] snippet];
        if (description.length) {
            [self.headerCell setSnippet:description];
        } else {
            [self.headerCell setSnippet:@"No description available."];
        }
    } else {
        [self.headerCell setSnippet:@"No description available."];
    }
    [self.headerCell setIsLoading:NO];
}

#pragma mark - actions
-(void)doneAction:(UIBarButtonItem *)createButton {
    [self finishBookWithSuccessCallback:^{
        [self savePageChangedIfNeeded];
        [self.navigationController popViewControllerAnimated:YES];
        [[REDDataStack sharedManager] commit];
        if (self.actionType == REDBookAddViewControllerActionTypeEditing) {
            [Localytics tagEvent:@"Edit Book"];
            [Answers logContentViewWithName:@"Book"
                                contentType:@"Viewing"
                                  contentId:@""
                           customAttributes:@{}];
        } else if (self.actionType == REDBookAddViewControllerActionTypeAdding) {
            [Localytics tagEvent:@"Add Book"];
            [Answers logContentViewWithName:@"Book"
                                contentType:@"Adding"
                                  contentId:@""
                           customAttributes:@{}];
        } else {
            [Localytics tagEvent:@"Added Transient Book"];
            [Answers logContentViewWithName:@"Book"
                                contentType:@"Added Transient"
                                  contentId:@""
                           customAttributes:@{}];
        }
    }];
}
-(void)cancelAction:(UIBarButtonItem *)cancelButton {
    if (self.actionType == REDBookAddViewControllerActionTypeTransientBook || self.actionType == REDBookAddViewControllerActionTypeAdding) {
        [self savePageChangedIfNeeded];
        [self.bookDataAccessObject remove:self.book];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
}

@end
