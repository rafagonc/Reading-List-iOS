//
//  REDBookListViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDLibraryViewController.h"
#import "REDDatasourceProtocol.h"
#import "REDBookProtocol.h"
#import "REDNavigationBarCustomizer.h"
#import "REDBookAddViewController.h"
#import "REDBookDatasourceDelegate.h"
#import "UISearchBar+Toolbar.h"
#import "REDBookDataAccessObject.h"
#import "REDTabBarCustomizer.h"
#import "REDNewViewController.h"
#import "REDBookRepositoryFactory.h"
#import "REDUserProtocol.h"
#import "REDTutorialViewController.h"
#import "UIViewController+NotificationShow.h"
#import "REDTutorialCreator.h"
#import "REDLibraryDatasourceFactory.h"
#import "REDLibraryDataProvider.h"
#import "REDAuthorDatasourceDelegate.h"
#import "REDAuthorDatasource.h"
#import "REDCategoryDatasourceDelegate.h"
#import "REDBookPredicateViewController.h"

@interface REDLibraryViewController () <REDBookDatasourceDelegate, UISearchBarDelegate, REDAuthorDatasourceDelegate, REDCategoryDatasourceDelegate> {
    UIBarButtonItem *doneButton, *editButton;
}

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *saerchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

#pragma mark - properties
@property (nonatomic,strong) id<REDBookRepository> bookRepository;
@property (nonatomic,strong) id<REDDatasourceProtocol> datasource;

#pragma mark - injected
@property (setter=injected1:) id<REDBookDataAccessObject> bookDataAccessObject;
@property (setter=injected2:) id<REDBookRepositoryFactory> bookRepositoryFactory;
@property (setter=injected3:) id<REDUserProtocol> user;
@property (setter=injected4:) id<REDLibraryDatasourceFactory> libraryDatasourceFactory;

@end

@implementation REDLibraryViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        self.title = @"Library";
        self.tabBarItem.image = [UIImage imageNamed:@"book"];
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [Localytics tagScreen:@"Library Screen"];
    
    [self.saerchBar addToolbar];
    self.saerchBar.delegate = self;
    
    self.datasource = [self.libraryDatasourceFactory datasourceForType:REDLibraryTypeBooks];
    self.tableView.delegate = self.datasource;
    self.tableView.dataSource = self.datasource;
    [self.datasource setDelegate:self];
    [self updateDataWithType:self.segmentedControl.selectedSegmentIndex];
    [self.tableView reloadData];
    
    [self setUpBarButtonItems];
    
    [REDTutorialCreator showTutorialOn:self];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar];
    [REDTabBarCustomizer customizeTabBar:self.tabBarController.tabBar];
    [self.tableView reloadData];
    [self.saerchBar setText:@""];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    [self updateDataWithType:self.segmentedControl.selectedSegmentIndex]; /*deixar no did */
}

#pragma mark - setups
-(void)setUpBarButtonItems {
    editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction:)];
    [self.navigationItem setLeftBarButtonItem:editButton];
    
    doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editAction:)];
    
    UIBarButtonItem *addAction = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    [self.navigationItem setRightBarButtonItem:addAction];
}

#pragma mark - datasource protocols
-(void)datasource:(id<REDDatasourceProtocol>)datasource didSelectBook:(id<REDBookProtocol>)book {
    REDBookAddViewController *editViewController = [[REDBookAddViewController alloc] initWithBook:book];
    [self.navigationController pushViewController:editViewController animated:YES];
}
-(void)datasource:(id<REDDatasourceProtocol>)datasource didDeleteBook:(id<REDBookProtocol>)book {
    self.bookRepository = [self.bookRepositoryFactory repository];
    [self.bookRepository removeForUser:self.user book:book callback:^() {
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.datasource.data indexOfObject:book] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self updateDataWithType:self.segmentedControl.selectedSegmentIndex];
        [self.tableView endUpdates];
    } error:^(NSError *error) {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:error.localizedDescription];
    }];

}
-(BOOL)datasourceCanEditBooks:(id<REDDatasourceProtocol>)datasource {
    return YES;
}
-(BOOL)datasourceShouldShowAccessoryType:(id<REDDatasourceProtocol>)datasource {
    return YES;
}
-(void)authorDatasource:(id<REDDatasourceProtocol>)authorDatasource didSelectAuthor:(id<REDAuthorProtocol>)author {
    REDBookPredicateViewController * bookPredicateViewController = [[REDBookPredicateViewController alloc] initWithPrediate:[NSPredicate predicateWithFormat:@"author.name LIKE[cd] %@", [author name]]];
    [bookPredicateViewController setNavigationBarTitle:[author name]];
    [self.navigationController pushViewController:bookPredicateViewController animated:YES];
}
-(void)categoryDatasource:(id<REDDatasourceProtocol>)datasource didSelectCategory:(id<REDCategoryProtocol>)category {
    REDBookPredicateViewController * bookPredicateViewController = [[REDBookPredicateViewController alloc] initWithPrediate:[NSPredicate predicateWithFormat:@"category.name LIKE[cd] %@", [category name]]];
    [bookPredicateViewController setNavigationBarTitle:[category name]];
    [self.navigationController pushViewController:bookPredicateViewController animated:YES];
}

#pragma mark - search bar protocl
-(void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self updateDataWithType:self.segmentedControl.selectedSegmentIndex];
    [self.tableView reloadData];
}
-(BOOL)isSearcingBooks {
    return self.saerchBar.text.length > 0;
}

#pragma mark - actions
-(void)addAction:(UIBarButtonItem *)addbutton {
    REDBookAddViewController *detailViewController = [[REDBookAddViewController alloc] init];
    [self.navigationController pushViewController:detailViewController animated:YES];
}
-(void)editAction:(UIBarButtonItem *)editAction {
    if (self.segmentedControl.selectedSegmentIndex != REDLibraryTypeBooks) return;
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    [self.navigationItem setLeftBarButtonItem:self.tableView.editing ? doneButton : editButton];
}
-(void)segmentedControlChanged:(UISegmentedControl *)sender {
    [self changeType:sender.selectedSegmentIndex];
}
-(void)changeType:(REDLibraryType)type {
    [self.segmentedControl setSelectedSegmentIndex:type];
    self.datasource = [self.libraryDatasourceFactory datasourceForType:type];
    self.tableView.delegate = self.datasource;
    self.tableView.dataSource = self.datasource;
    [self.datasource setDelegate:self];
    [self updateDataWithType:type];
    [self.tableView reloadData];
}

#pragma mark - methods
-(void)updateDataWithType:(REDLibraryType)type {
    NSError * error;
    if ([self isSearcingBooks]) {
        [[REDLibraryDataProvider new] dataForType:type withNameFilter:[self.saerchBar.text copy] callback:^(id data) {
            [self.datasource setData:data];
        } error:&error];
    } else {
        [[REDLibraryDataProvider new] dataForType:type callback:^(id data) {
            [self.datasource setData:data];
        } error:&error];
    }
    if (error) [self showNotificationWithType:SHNotificationViewTypeError withMessage:error.localizedDescription];
}

@end
