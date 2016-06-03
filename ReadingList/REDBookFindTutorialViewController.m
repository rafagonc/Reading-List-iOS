//
//  RAKBookFindTutorialViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDBookFindTutorialViewController.h"
#import "REDBookDataAccessObject.h"
#import "REDDatasourceProtocol.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDTransientBookDatasourceDelegate.h"
#import "REDTransientBook.h"
#import "REDGoogleBooksQueryRequest.h"
#import "UITextField+DoneButton.h"
#import "REDServiceResponseProtocol.h"
#import "REDCollectionViewDatasourceProtocol.h"
#import "REDTransientBookCompletedAdapter.h"
#import "UIViewController+NotificationShow.h"
#import "REDTransientBookCollectionViewDelegate.h"

@interface REDBookFindTutorialViewController () <REDTransientBookCollectionViewDelegate, UITextFieldDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITextField *bookNameTextField;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

#pragma mark - properties
@property (nonatomic,strong) NSMutableArray <REDTransientBook *> * books;

#pragma mark - injected
@property (setter=injected1:) id<REDBookDataAccessObject> bookDataAccessObject;
@property (setter=injected_transientBook:) id<REDCollectionViewDatasourceProtocol> datasource;
@property (setter=injected2:) id<REDServiceDispatcherProtocol> serviceDispatcher;


@end

@implementation REDBookFindTutorialViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super init]) {
        self.books = [@[] mutableCopy];
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.bookNameTextField addToolbar];
    
    NSString * collectionCellClassName = @"REDTransientBookCollectionViewCell";
    [self.collectionView registerNib:[UINib nibWithNibName:collectionCellClassName bundle:nil] forCellWithReuseIdentifier:collectionCellClassName];
    [self.collectionView setDataSource:self.datasource];
    [self.collectionView setDelegate:self.datasource];
    [self.datasource setDelegate:self];
    
    [self.bookNameTextField setDelegate:self];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - text field delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length != 0) [self callGoogleQueryRequest];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - delegate
-(void)transientBookDatasource:(id<REDCollectionViewDatasourceProtocol>)datasource justRemovedBook:(REDTransientBook *)book {
    [self.books removeObject:book];
}
-(void)transientBookDatasource:(id<REDCollectionViewDatasourceProtocol>)datasource justAddedBook:(REDTransientBook *)book {
    [self.books addObject:book];
}


#pragma mark - service
-(void)callGoogleQueryRequest {
    [self.datasource setData:@[]];
    [self.collectionView reloadData];
    [self.activityIndicator startAnimating];
    REDGoogleBooksQueryRequest * request = [[REDGoogleBooksQueryRequest alloc] initWithQuery:[self.bookNameTextField text]];
    [self.serviceDispatcher callWithRequest:request withTarget:self andSelector:@selector(response:)];
}
-(void)response:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = [notification object];
    if ([response success]) {
        NSMutableArray * bookAdapter = [@[] mutableCopy];
        for (REDTransientBook * book in [response data]) {
            REDTransientBookCompletedAdapter * completedAdapter = [[REDTransientBookCompletedAdapter alloc] initWithTransientBook:book];
            [bookAdapter addObject:completedAdapter];
        }
        [self.datasource setData:bookAdapter];
        [self.collectionView reloadData];
    } else {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:[response error].localizedDescription];
    }
    [self.activityIndicator stopAnimating];
}

#pragma mark - dealloc
-(void)dealloc {
    
}

@end
