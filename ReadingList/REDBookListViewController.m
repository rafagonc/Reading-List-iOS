//
//  REDBookListViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookListViewController.h"
#import "REDDatasourceProtocol.h"
#import "REDBookProtocol.h"
#import "REDEntityFetcher.h"
#import "REDNavigationBarCustomizer.h"
#import "REDBookAddViewController.h"
#import "REDBookDatasourceDelegate.h"
#import "UISearchBar+Toolbar.h"

@interface REDBookListViewController () <REDBookDatasourceDelegate, UISearchBarDelegate> {
    UIBarButtonItem *doneButton, *editButton;
}

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *saerchBar;

#pragma mark - injected
@property (setter=injected_book:, readonly) id<REDDatasourceProtocol> datasource;

@end

@implementation REDBookListViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Books";
    
    [self.saerchBar addToolbar];
    self.saerchBar.delegate = self;
    
    self.tableView.delegate = self.datasource;
    self.tableView.dataSource = self.datasource;
    [self.datasource setDelegate:self];
    
    [self updateData];
    [self.tableView reloadData];
    [self setUpBarButtonItems];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar];
    [self updateData];
    [self.tableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self updateData];
    [self.tableView reloadData];
}

#pragma mark - setups
-(void)setUpBarButtonItems {
    editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction:)];
    [self.navigationItem setLeftBarButtonItem:editButton];
    
    doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editAction:)];
}

#pragma mark - book datasource protocol
-(void)datasource:(id<REDDatasourceProtocol>)datasource didSelectBook:(id<REDBookProtocol>)book {
    REDBookAddViewController *editViewController = [[REDBookAddViewController alloc] initWithBook:book];
    [self.navigationController pushViewController:editViewController animated:YES];
}
-(void)datasource:(id<REDDatasourceProtocol>)datasource didDeleteBook:(id<REDBookProtocol>)book {
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.datasource.data indexOfObject:book] inSection:0]] withRowAnimation:UITableViewRowAnimationMiddle];
    [self updateData];
    [self.tableView endUpdates];
}
-(void)datasourceWantsToAddNewBook:(id<REDDatasourceProtocol>)datasource {
    REDBookAddViewController *detailViewController = [[REDBookAddViewController alloc] init]
    ;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

#pragma mark - search bar protocl
#warning MOVE SEARCH BAR DELEGATE OUT
-(void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self updateData];
}

#pragma mark - actions
-(void)addAction:(UIBarButtonItem *)addbutton {
    REDBookAddViewController *detailViewController = [[REDBookAddViewController alloc] init]
    ;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:detailViewController] animated:YES completion:nil];
}
-(void)editAction:(UIBarButtonItem *)editAction {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    [self.navigationItem setLeftBarButtonItem:self.tableView.editing ? doneButton : editButton];
}
-(void)infoAction:(UIBarButtonItem *)infoButton {
    
}

#pragma mark - methods
-(void)updateData {
    if (self.saerchBar.text.length > 0)  {
     [self.datasource setData:[[[[REDEntityFetcher withProtocol:@protocol(REDBookProtocol)] setPredicate:[NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", self.saerchBar.text]] all] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"completed" ascending:YES]]]];
        [self.tableView reloadData];
    } else {
        [self.datasource setData:[[[REDEntityFetcher withProtocol:@protocol(REDBookProtocol)] all] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"completed" ascending:YES]]]];
        [self.tableView reloadData];
    }
}

@end
