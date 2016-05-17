//
//  REDRecommendedBooksViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDExploreViewController.h"
#import "REDTabBarCustomizer.h"
#import "REDNavigationBarCustomizer.h"
#import "REDServiceDispatcher.h"
#import "REDServiceResponseProtocol.h"
#import "REDGoogleBooksQueryRequest.h"
#import "UIViewController+NotificationShow.h"
#import "UIViewController+Loading.h"
#import "REDDatasourceProtocol.h"
#import "REDCategoryDataAccessObject.h"
#import "REDBookDataAccessObject.h"
#import "REDTransientBookDatasourceDelegate.h"
#import "REDBookAddViewController.h"
#import "REDBookDataAccessObject.h"
#import "UISearchBar+Toolbar.h"
#import "REDTopRatedRequest.h"
#import "REDRequestFeature.h"
#import "REDBookQueryService.h"


@interface REDExploreViewController ()

<REDTransientBookDatasourceDelegate, UISearchBarDelegate>

{
    dispatch_group_t services;
}

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;

#pragma mark - properties
@property (nonatomic,strong) NSMutableDictionary * mData;
@property (nonatomic,assign) BOOL wait; /* indicate the need to wait for both web services */
@property (weak,  nonatomic) IBOutlet UIButton *requestFeatureButton;

#pragma mark - injected
@property (setter=injected1:) id<REDBookQueryService> bookQueryService;
@property (setter=injected2:) id<REDRequestFeature> requestFeature;
@property (setter=injected3:) id<REDServiceDispatcherProtocol> dispatcher;
@property (setter=injected4:) id<REDCategoryDataAccessObject> categoryDataAccessObject;
@property (setter=injected5:) id<REDBookDataAccessObject> bookDataAccessObject;
@property (setter=injected_transientBook:) id<REDDatasourceProtocol> datasource;

@end

@implementation REDExploreViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.title = @"Explore";
        self.tabBarItem.image = [UIImage imageNamed:@"Explore"];
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    self.mData = [[NSMutableDictionary alloc] init];
    
    [self.searchBar addToolbar];
    [self.searchBar setDelegate:self];
    [self.datasource setDelegate:self];
    [self.tableView setDataSource:self.datasource];
    [self.tableView setDelegate:self.datasource];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView reloadData];
    
    if ([self hasAddedAnyBook]) {
        self.emptyLabel.hidden = YES;
        self.requestFeatureButton.hidden = NO;
    } else {
        self.requestFeatureButton.hidden = YES;
        self.emptyLabel.hidden = NO;
    }
    
    [self refresh];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar];
    [REDTabBarCustomizer customizeTabBar:self.tabBarController.tabBar];
    
    if ([self hasAddedAnyBook]) {
        self.emptyLabel.hidden = YES;
    } else {
        self.emptyLabel.hidden = NO;
    }
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    [self.navigationItem setLeftBarButtonItem:refreshButton];
}

#pragma mark - delegate
-(void)datasource:(id<REDDatasourceProtocol>)datasource wantsToAddTransientBook:(REDTransientBook *)transientBook {
    REDBookAddViewController *addBook = [[REDBookAddViewController alloc] initWithBook:transientBook];
    [self.navigationController pushViewController:addBook animated:YES];
}
-(void)datasource:(id<REDDatasourceProtocol>)datasource wantsToCheckOutTopRatedBook:(id<REDTopRatedBook>)book {
    REDBookAddViewController *addViewController = [[REDBookAddViewController alloc] initWithBook:book];
    [self.navigationController pushViewController:addViewController animated:YES];
}

#pragma mark - search bar delegate
-(void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self startFullLoading];
    [self callGoogleBooksQueryService];
}

#pragma mark - service
-(void)callTopRatedBooks {
    //dispatch_group_enter(services);
    REDTopRatedRequest *request = [[REDTopRatedRequest alloc] init];
    [self.dispatcher callWithRequest:request withTarget:self andSelector:@selector(topRatedBooksResponse:)];
}
-(void)callGoogleBooksQueryService {
    //if (self.wait) dispatch_group_enter(services);
    REDGoogleBooksQueryRequest *request = [[REDGoogleBooksQueryRequest alloc] initWithQuery:[self searchString]];
    [self.dispatcher callWithRequest:request withTarget:self andSelector:@selector(response:)];
}
-(void)response:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = notification.object;
    if ([response success]) {
        self.mData[REDRecommendedBooksViewControllerSearchKey] = [response data];
        [self.datasource setData:self.mData];
        [self.tableView reloadData];
    } else {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:[[response error] localizedDescription]];
    }
    //if (self.wait) dispatch_group_leave(services);
    [self stopFullLoading];

}
-(void)topRatedBooksResponse:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = notification.object;
    if ([response success]) {
        self.mData[REDRecommendedBooksViewControllerTopRatedKey] = [[response data] subarrayWithRange:NSMakeRange(0, MIN([[response data] count], 5))];
        [self.datasource setData:self.mData];
        [self.tableView reloadData];
        
    } else {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:[[response error] localizedDescription]];

    }
    [self stopFullLoading];
    //if (self.wait) dispatch_group_leave(services);
}

#pragma mark - getters
-(NSString *)searchString {
    if (self.searchBar.text.length) {
        return self.searchBar.text;
    } else if ([self.bookDataAccessObject list].count) {
        return [self.categoryDataAccessObject mostUsedCategoryName];
    } else return nil;
}
-(BOOL)hasAddedAnyBook {
    return [self.bookDataAccessObject list].count > 0;
}

#pragma mark - actions
-(IBAction)requestFeatureAction:(id)sender {
    [self.requestFeature request:self];
}
-(void)refresh{
    self.wait = YES;
    [self startFullLoading];
    [self callTopRatedBooks];
    if ([self hasAddedAnyBook]) [self callGoogleBooksQueryService];
//    dispatch_group_notify(services, dispatch_get_main_queue(), ^{
//        welf.wait = NO;
//        [welf stopFullLoading];
//    });
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}


@end
