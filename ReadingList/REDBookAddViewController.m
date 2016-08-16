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
#import "UIColor+ReadingList.h"
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
#import "REDAddNoteViewController.h"
#import "REDNoteCell.h"
#import "REDNotesDataAccessObject.h"
#import "REDNoteRepositoryFactory.h"
#import "UITableView+Autoresize.h"

typedef NS_ENUM(NSUInteger, REDBookAddViewControllerActionType) {
    REDBookAddViewControllerActionTypeAdding,
    REDBookAddViewControllerActionTypeEditing,
    REDBookAddViewControllerActionTypeTransientBook,
};

@interface REDBookAddViewController ()

<REDBookCategoryCellDelegate, REDBookPagesCellDelegate, REDBookHeaderCellDelegate, REDPageProgressCellDelegate, REDNoteCellDelegate, REDAddNoteViewControllerDelegate>

#pragma mark - properties
@property (nonatomic,strong) id<REDBookProtocol> book;
@property (nonatomic,strong) id<REDBookProtocol> transientBook;
@property (nonatomic,assign) REDBookAddViewControllerActionType actionType;

#pragma mark - ui
@property (nonatomic,strong) NSMutableArray<REDNoteCell *> * notesCell;
@property (nonatomic,strong) REDBookCategoryCell *categoryCell;
@property (nonatomic,strong) REDBookHeaderCell * headerCell;
@property (nonatomic,strong) REDBookPagesCell * pagesCell;
@property (nonatomic,strong) REDPageProgressCell *progressCell;
@property (nonatomic,  weak) IBOutlet UIStaticTableView *tableView;
@property (nonatomic,  weak) IBOutlet UILabel *quoteLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomConstraint;

#pragma mark - injected
@property (setter=injected_share:) id<REDValidator> shareValidator;
@property (setter=injected_name:) id<REDValidator> bookNameValidator;
@property (setter=injected_author:) id<REDValidator> authorValidator;
@property (setter=injected1:) id<REDUserProtocol> user;
@property (setter=injected2:) id<REDBookUploaderProtocol> bookUploader;
@property (setter=injected3:) id<REDBookRepositoryFactory> bookRepositoryFactory;
@property (setter=injected4:) id<REDTransactionManager> transactionManager;
@property (setter=injected5:) id<REDReadFactoryProtocol> readFactory;;
@property (setter=injected6:) id<REDBookDataAccessObject> bookDataAccessObject;
@property (setter=injected7:) id<REDServiceDispatcherProtocol> serviceDispatcher;
@property (setter=injected8:) id<REDNoteRepositoryFactory> noteRepositoryFactory;

@end

@implementation REDBookAddViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.book = [self.bookDataAccessObject create];
        self.actionType = REDBookAddViewControllerActionTypeAdding;
        self.notesCell = [@[] mutableCopy];
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
        self.notesCell = [@[] mutableCopy];
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.actionType == REDBookAddViewControllerActionTypeAdding || self.actionType == REDBookAddViewControllerActionTypeTransientBook ? @"New Book" : @"Edit Book";
    
    [Localytics tagScreen:self.title];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
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
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"check"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(doneAction:)];
    [doneButton setTintColor:[UIColor red_redColor]];
    [self.navigationItem setRightBarButtonItem:doneButton];
    
    UIBarButtonItem * cancelButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"cancel"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    [cancelButton setTintColor:[UIColor colorWithWhite:0.8 alpha:1]];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
}

#pragma mark - table view
-(void)createTableView {
    [self.tableView clean];
    [self.tableView automaticallyResizeOnKeyboardEvent];
    
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
    
    for (id<REDNotesProtocol> note in self.book.notes) {
        REDNoteCell * noteCell = [[REDNoteCell alloc] init];
        [noteCell setNote:note];
        [noteCell setDelegate:self];
        [self.tableView addCell:noteCell onSection:section];
        [self.notesCell addObject:noteCell];
    }
    
    [self.tableView addSection:section];
}

#pragma mark - process book
-(void)resignAllNoteTextViews {
    for (REDNoteCell * cell in self.notesCell) {
        [cell resignFirstResponder];
    }
}
-(void)processBookWithCallback:(void(^)(BOOL success, NSError * out_error))callback {
    [self resignAllNoteTextViews];
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
    if (self.headerCell.didChangeRate) {
        [self.bookUploader uploadBook:self.book forRating:self.headerCell.rating];
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
    if (![self.bookNameValidator validate:self.headerCell.nameTextField.text error:&error]) {
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
    [Localytics tagEvent:@"Page Progress" attributes:@{}];
    [self.progressCell setPages:pages];
}
-(void)pageProgressCell:(REDPageProgressCell *)cell tryingToSetPagesWhileIsZeroForBook:(id<REDBookProtocol>)book {
    [self showNotificationWithType:SHNotificationViewTypeError withMessage:@"Set the pages before reading it!"];
}
-(void)pageProgressCell:(REDPageProgressCell *)cell didCompleteBookReading:(id<REDBookProtocol>)book {
    [Localytics tagEvent:@"Completed Book" attributes:@{}];
    REDPleaseRateViewController *rateViewController = [[REDPleaseRateViewController alloc] initWithBook:self.book];
    [self presentViewController:rateViewController animated:YES completion:nil];
}
-(void)bookHeaderCellWantsToAddNote:(REDBookHeaderCell *)cell {
    [Localytics tagEvent:@"Add Note"];
    REDAddNoteViewController * noteViewController = [[REDAddNoteViewController alloc] initWithBook:self.book];
    noteViewController.delegate = self;
    [self presentViewController:noteViewController animated:YES completion:nil];
}
-(void)bookHeaderCellWantsToShareProgress:(REDBookHeaderCell *)cell {
    NSError * error;
    if ([self.shareValidator validate:self.book error:&error] == NO) {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:error.localizedDescription];
        return;
    }
    
    [Localytics tagEvent:@"Share Progress"];
    NSMutableArray *sharingItems = [NSMutableArray new];
    [sharingItems addObject:[NSString stringWithFormat:@"%@/%@ completed - %@",@([self.book pagesReadValue]), @([self.book pagesValue]), [self.book name]]];
    if ([self.book coverImage]) [sharingItems addObject:[self.book coverImage]];
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [self presentViewController:activityController animated:YES completion:nil];
}
-(void)noteCell:(REDNoteCell *)cell didUpdateNote:(id<REDNotesProtocol>)note {
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}
-(void)noteCell:(REDNoteCell *)cell wantsToOpenNote:(id<REDNotesProtocol>)note {
    REDAddNoteViewController * noteViewController = [[REDAddNoteViewController alloc] initWithBook:self.book andNote:note];
    noteViewController.delegate = self;
    [self presentViewController:noteViewController animated:YES completion:nil];
}
-(void)noteCell:(REDNoteCell *)cell wantsToDeleteNote:(id<REDNotesProtocol>)note {
    if (cell) {
        [[self.noteRepositoryFactory repository] removeForUser:self.user note:note callback:^{
            [self createTableView];
        } error:^(NSError *error) {
            [self showNotificationWithType:SHNotificationViewTypeError withMessage:[error localizedDescription]];
        }];
    } else {
        [self createTableView];
    }
    
}
-(void)addNoteViewController:(REDAddNoteViewController *)addNoteViewController didJustAddNote:(id<REDNotesProtocol>)note {
    [self createTableView];
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

#pragma mark - keyboard
-(void)keyboardChangeFrame:(NSNotification *)notif {
    CGRect rect = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.tableViewBottomConstraint.constant = rect.size.height;
    [self.view layoutIfNeeded];
}
-(void)keyboardDidHide:(NSNotification *)notif {
    self.tableViewBottomConstraint.constant = 0;
    [self.view layoutIfNeeded];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
}

@end
