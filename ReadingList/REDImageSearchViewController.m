//
//  REDImageSearchViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/16/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDImageSearchViewController.h"
#import "REDNavigationBarCustomizer.h"
#import "REDImageSearchRequest.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDServiceResponseProtocol.h"
#import "REDCollectionViewDatasourceProtocol.h"
#import "REDNavigationBarCustomizer.h"
#import "REDImageSearchCollectionViewDatasourceDelegate.h"
#import "UIViewController+Loading.h"
#import "UIViewController+NotificationShow.h"

@interface REDImageSearchViewController () <REDImageSearchCollectionViewDatasourceDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

#pragma mark - injected
@property (setter=injected:,readonly) id<REDServiceDispatcherProtocol> dispatcher;
@property (setter=injected_googleImage:,readonly) id<REDCollectionViewDatasourceProtocol> datasource;

#pragma mark - property
@property (nonatomic,strong) NSString *bookName;
@property (nonatomic,strong) NSString *authorName;

@end

@implementation REDImageSearchViewController

#pragma mark - init
-(instancetype)initWithBookName:(NSString *)bookName andAuthor:(NSString *)author {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.authorName = author;
        self.bookName = bookName;
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Choose Cover";
    
    self.collectionView.dataSource = self.datasource;
    self.collectionView.delegate = self.datasource;
    [self.datasource setDelegate:self];
    
    [self.collectionView reloadData];
    [self setUpBarButtonItems];
    [self consume];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar];
}

#pragma mark - setups
-(void)setUpBarButtonItems {
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    [self.navigationItem setRightBarButtonItem:doneButton];
    
    UIBarButtonItem * cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    [self.navigationItem setLeftBarButtonItem:cancelButton];
    
}

#pragma mark - service
-(void)consume {
    [self startFullLoading];
    REDImageSearchRequest *request = [[REDImageSearchRequest alloc] initWithQuery:[self query]];
    [request nextPage];
    [self.dispatcher callWithRequest:request withTarget:self andSelector:@selector(response:)];
}
-(void)response:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = notification.object;
    if ([response success]) {
        [self.datasource setData:[response data]];
        [self.collectionView reloadData];
    } else {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:[[response error] localizedDescription]];
    }
    [self stopFullLoading];
}

#pragma mark - datasource delegate
-(void)datasource:(id<REDCollectionViewDatasourceProtocol>)datasource didSelectImage:(UIImage *)image error:(NSError *)error {
    if (!error) {
        if (self.callback) self.callback(image);
        self.callback = nil;
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:[error localizedDescription]];
    }
}

#pragma mark - getters
-(NSString *)query {
    return [NSString stringWithFormat:@"%@ - %@", self.bookName, self.authorName];
}

#pragma mark - actions
-(void)doneAction:(UIBarButtonItem *)item {
    
}
-(void)cancelAction:(UIBarButtonItem *)item {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}

@end
