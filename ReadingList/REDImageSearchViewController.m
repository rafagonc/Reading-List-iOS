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
#import "REDNavigationBarCustomizer.h"

@interface REDImageSearchViewController ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

#pragma mark - injected
@property (setter=injected:,readonly) id<REDServiceDispatcherProtocol> dispatcher;

@end

@implementation REDImageSearchViewController

#pragma mark - init
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Choose Image";
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
    REDImageSearchRequest *request = [[REDImageSearchRequest alloc] initWithQuery:@"monkey"];
    [request nextPage];
    [self.dispatcher callWithRequest:request withTarget:self andSelector:@selector(response:)];
}
-(void)response:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = notification.object;
    if ([response success]) {
        
    } else {
        
    }
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
