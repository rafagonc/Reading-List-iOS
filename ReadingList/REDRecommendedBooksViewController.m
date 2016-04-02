//
//  REDRecommendedBooksViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDRecommendedBooksViewController.h"
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

@interface REDRecommendedBooksViewController ()

<REDTransientBookDatasourceDelegate, UISearchBarDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;

#pragma mark - injected
@property (setter=injected:) id<REDServiceDispatcherProtocol> dispatcher;
@property (setter=injected:) id<REDCategoryDataAccessObject> categoryDataAccessObject;
@property (setter=injected:) id<REDBookDataAccessObject> bookDataAccessObject;
@property (setter=injected_transientBook:,readonly) id<REDDatasourceProtocol> datasource;

@end

@implementation REDRecommendedBooksViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.title = @"Recommended";
        self.tabBarItem.image = [UIImage imageNamed:@"Search"];
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self.searchBar addToolbar];
    [self.searchBar setDelegate:self];
    [self.datasource setDelegate:self];
    [self.tableView setDataSource:self.datasource];
    [self.tableView setDelegate:self.datasource];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView reloadData];
    
    if ([self hasAddedAnyBook]) {
        self.emptyLabel.hidden = YES;
        [self callGoodReadsQueryService];
    } else {
        self.emptyLabel.hidden = NO;
    }
    
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
}

#pragma mark - delegate
-(void)datasource:(id<REDDatasourceProtocol>)datasource wantsToAddTransientBook:(REDTransientBook *)transientBook {
    REDBookAddViewController *addBook = [[REDBookAddViewController alloc] initWithBook:transientBook];
    [self.navigationController pushViewController:addBook animated:YES];
}

#pragma mark - search bar delegate
-(void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self callGoodReadsQueryService];
}

#pragma mark - service
-(void)callGoodReadsQueryService {
    [self startFullLoading];
    REDGoogleBooksQueryRequest *request = [[REDGoogleBooksQueryRequest alloc] initWithQuery:[self searchString]];
    [self.dispatcher callWithRequest:request withTarget:self andSelector:@selector(response:)];
}
-(void)response:(NSNotification *)notification {
    id<REDServiceResponseProtocol> response = notification.object;
    if ([response success]) {
        [self.datasource setData:[response data]];
        [self.tableView reloadData];
    } else {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:[[response error] localizedDescription]];
    }
    [self stopFullLoading];
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

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}


@end
