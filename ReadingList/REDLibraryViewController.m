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
#import "ZBarSDK.h"
#import "UIColor+ReadingList.h"
#import "REDNewOptionsViewController.h"
#import "REDGoogleBooksQueryRequest.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDServiceResponseProtocol.h"
#import "UIViewController+Loading.h"
#import "REDAuthorRemover.h"
#import "REDAuthorCreateViewController.h"
#import "UIStaticTableView.h"
#import "REDUserCell.h"
#import "REDSegmentedCell.h"
#import "REDLibraryCell.h"
#import "REDPhotoPickerPresenterProtocol.h"
#import "REDTransactionManager.h"
#import "REDSignUpViewController.h"
#import "REDChartViewController.h"
#import "UISearchBar+Toolbar.h"
#import "REDCategoryCreateViewController.h"
#import "UITableView+Autoresize.h"
#import "REDAddLogViewController.h"

@interface REDLibraryViewController ()

<ZBarReaderDelegate, REDUserCellDelegate, REDSegmentedCellDelegate, REDLibraryCellDelegate, REDLibraryViewDatasourceDelegate, UISearchResultsUpdating, UISearchBarDelegate>

{
    UIBarButtonItem *doneButton, *editButton;
    UIStaticTableViewSection * section;
}

#pragma mark - table view
@property (weak, nonatomic) IBOutlet UIStaticTableView *staticTableView;

#pragma mark - ui
@property (weak, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) UISearchController * searchController;
@property (weak, nonatomic) REDUserCell *userCell;
@property (weak, nonatomic) REDLibraryCell *libraryCell;
@property (weak, nonatomic) REDSegmentedCell *segmentedCell;

#pragma mark - properties
@property (nonatomic,strong) id<REDBookRepository> bookRepository;
@property (nonatomic,strong) id<REDDatasourceProtocol> datasource;

#pragma mark - injected
@property (setter=injected1:) id<REDBookDataAccessObject> bookDataAccessObject;
@property (setter=injected2:) id<REDBookRepositoryFactory> bookRepositoryFactory;
@property (setter=injected3:) id<REDUserProtocol> user;
@property (setter=injected4:) id<REDLibraryDatasourceFactory> libraryDatasourceFactory;
@property (setter=injected5:) id<REDServiceDispatcherProtocol> serviceDispatcher;
@property (setter=injected6:) id<REDAuthorRemover> authorRemover;
@property (setter=injected7:) id<REDPhotoPickerPresenterProtocol> photoPicker;
@property (setter=injected8:) id<REDTransactionManager> transactionManager;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [self createTableView];
    
    [self setUpBarButtonItems];
        
    [self setUpSearchController];
    
    [REDTutorialCreator showTutorialOn:self];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar andItem:self.navigationItem];
    [REDTabBarCustomizer customizeTabBar:self.tabBarController.tabBar];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setClipsToBounds:NO];
    [self.libraryCell.libraryView update];
    [self.searchBar setText:@""];
    self.tabBarController.tabBar.hidden = NO;
}
-(void)viewDidAppear:(BOOL)animated {
    //[self.staticTableView setContentOffset:CGPointMake(0, 40) animated:YES];
    [self.searchBar resignFirstResponder];
    [self.searchController dismissViewControllerAnimated:YES completion:nil];
    [self.userCell update];
    [self.libraryCell.libraryView sync];
}
-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark - setups
-(void)setUpBarButtonItems {
    editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editAction:)];
    [self.navigationItem setLeftBarButtonItem:editButton];
    
    doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(editAction:)];
    
    UIBarButtonItem *addAction = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction:)];
    [self.navigationItem setRightBarButtonItem:addAction];
    
    UIBarButtonItem *barAction = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barcode"] style:UIBarButtonItemStylePlain target:self action:@selector(barAction:)];
    [self.navigationItem setRightBarButtonItems:@[addAction, barAction]];
}
-(void)setUpSearchController {
    [self setDefinesPresentationContext:YES];
    UISearchController * searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    [searchController setSearchResultsUpdater:self];
    [searchController setDimsBackgroundDuringPresentation:NO];
    [searchController setHidesNavigationBarDuringPresentation:YES];
    [self.staticTableView setTableHeaderView:searchController.searchBar];
    [self setSearchBar:searchController.searchBar];
    [self.searchBar setDelegate:self];
    [self.searchBar addToolbarWithCallback:^{
        [searchController dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.searchBar setSearchBarStyle:UISearchBarStyleMinimal];
    [self.searchBar setBackgroundColor:[UIColor whiteColor]];
    [self.searchBar setTintColor:[UIColor red_redColor]];
    [self setSearchController:searchController];
}

#pragma mark - orientation
-(void)orientationChanged:(NSNotification *)ntif {
    if ([self.navigationController.topViewController isEqual:self]) {
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        if (UIInterfaceOrientationIsLandscape(orientation)) {
            REDChartViewController *chartViewController = [[REDChartViewController alloc] init];
            [self.navigationController pushViewController:chartViewController animated:NO];
        } else {
            [self.navigationController setNavigationBarHidden:NO];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
    if (self.tabBarController.selectedIndex != 0) {
        [self.navigationController setNavigationBarHidden:NO];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark - create table view
-(void)createTableView {
    section = [[UIStaticTableViewSection alloc] init];
    
    REDUserCell * userCell = [[REDUserCell alloc] init];
    [userCell setUser:self.user];
    [userCell setDelegate:self];
    [self.staticTableView addCell:userCell onSection:section];
    [self setUserCell:userCell];
    
    REDSegmentedCell * segmentedCell = [[REDSegmentedCell alloc] init];
    [segmentedCell setDelegate:self];
    [self.staticTableView addCell:segmentedCell onSection:section];
    [self setSegmentedCell:segmentedCell];
    
    REDLibraryCell * libraryCell = [[REDLibraryCell alloc] init];
    [libraryCell setDelegate:self];
    [libraryCell.libraryView setDatasourceDelegate:self];
    [self.staticTableView addCell:libraryCell onSection:section];
    [self setLibraryCell:libraryCell];
    
    [self.staticTableView addSection:section];
}

#pragma mark - datasource protocols
-(void)libraryCellDidUpdate:(REDLibraryCell *)cell {
    [self.staticTableView reloadData];
}
-(void)libraryView:(REDLibraryView *)libraryView datasource:(id<REDDatasourceProtocol>)datasource didSelectCategory:(id<REDCategoryProtocol>)category error:(NSError *)error {
    REDBookPredicateViewController * bookPredicateViewController = [[REDBookPredicateViewController alloc] initWithPrediate:[NSPredicate predicateWithFormat:@"category.name LIKE[cd] %@", [category name]]];
    [bookPredicateViewController setNavigationBarTitle:[category name]];
    [self.navigationController pushViewController:bookPredicateViewController animated:YES];
}
-(void)libraryView:(REDLibraryView *)libraryView datasource:(id<REDDatasourceProtocol>)datasource wantsToEditAuthor:(id<REDAuthorProtocol>)author error:(NSError *)error {
    REDAuthorCreateViewController * authorCreate = [[REDAuthorCreateViewController alloc] initWithAuthor:author];
    [authorCreate setCallback:^(id<REDAuthorProtocol> author) {
    }];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:authorCreate] animated:YES completion:nil];
}
-(void)libraryView:(REDLibraryView *)libraryView datasource:(id<REDDatasourceProtocol>)datasource didSelectAuthor:(id<REDBookProtocol>)author error:(NSError *)error {
    REDBookPredicateViewController * bookPredicateViewController = [[REDBookPredicateViewController alloc] initWithPrediate:[NSPredicate predicateWithFormat:@"author.name LIKE[cd] %@", [author name]]];
    [bookPredicateViewController setNavigationBarTitle:[author name]];
    [self.navigationController pushViewController:bookPredicateViewController animated:YES];
    
}
-(void)libraryView:(REDLibraryView *)libraryView datasource:(id<REDDatasourceProtocol>)datasource didDeleteBook:(id<REDBookProtocol>)book error:(NSError *)error {
    if (error)
    [self showNotificationWithType:SHNotificationViewTypeError withMessage:error.localizedDescription];
}
-(void)libraryView:(REDLibraryView *)libraryView datasource:(id<REDDatasourceProtocol>)datasource didSelectBook:(id<REDBookProtocol>)book error:(NSError *)error {
    REDBookAddViewController *editViewController = [[REDBookAddViewController alloc] initWithBook:book];
    [self.navigationController pushViewController:editViewController animated:YES];
}
-(void)libraryView:(REDLibraryView *)libraryView datasource:(id<REDDatasourceProtocol>)datasource didChangeEditing:(BOOL)editing {
    [self.navigationItem setLeftBarButtonItem:self.libraryCell.libraryView.editing ? doneButton : editButton];
}
-(void)libraryView:(REDLibraryView *)libraryView datasource:(id<REDDatasourceProtocol>)datasource wantsToEditCategory:(id<REDCategoryProtocol>)category error:(NSError *)error {
    REDCategoryCreateViewController * categoryCreateViewController = [[REDCategoryCreateViewController alloc] initWithCategory:category];
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:categoryCreateViewController] animated:YES completion:nil];
}
-(void)segmetedCell:(REDSegmentedCell *)cell wantsToChangeType:(REDLibraryType)library {
    [self.libraryCell.libraryView setType:library];
}
-(void)userCellWantsToChangePhoto:(REDUserCell *)cell {
    __weak typeof(self) welf = self;
    [self.photoPicker pickPhotoFromViewController:self hasPhoto:[self.user hasPhoto] withCallback:^(UIImage *image, NSError *error) {
        if (error) {
            [self showNotificationWithType:SHNotificationViewTypeError withMessage:[error localizedDescription]];
        } else {
            [welf.transactionManager begin];
            [welf.user setPhoto:image];
            [welf.userCell setUser:welf.user];
            [welf.transactionManager commit];
        }
    }];
}
-(void)userCellWantsToOpen:(REDUserCell *)cell {
    [self.staticTableView beginUpdates];
    [UIView animateWithDuration:.6 delay:0 usingSpringWithDamping:.6 initialSpringVelocity:2 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.userCell setFrame:CGRectMake(self.userCell.frame.origin.x, self.userCell.frame.origin.y, self.userCell.frame.size.width, [self.userCell height])];
        [self.userCell layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    [self.staticTableView endUpdates];
}
-(void)userCellWantsToAuthenticate:(REDUserCell *)cell {
    REDSignUpViewController * signIn = [[REDSignUpViewController alloc] init];
    [self presentViewController:signIn animated:YES completion:nil];
}
-(void)userCellWantsToOpenChart:(REDUserCell *)cell {
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}
-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self.libraryCell.libraryView pleaseSirSearchForThisBooks:searchController.searchBar.text];
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.libraryCell.libraryView stopSearchNowSir];
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    if (searchBar.text.length == 0) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.searchBar setAlpha:0];
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.searchBar setAlpha:1];
            });
        }];
    };
    [self.staticTableView setContentOffset:CGPointMake(0, 30)];
    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [self.searchController dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - zbar
-(void)readerControllerDidFailToRead:(ZBarReaderController *)reader withRetry:(BOOL)retry {
    [reader dismissViewControllerAnimated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results) break;
    [picker dismissViewControllerAnimated:YES completion:^{
        if (symbol.data) {
            [self startFullLoading];
            REDGoogleBooksQueryRequest * googleRequest = [[REDGoogleBooksQueryRequest alloc] initWithQuery:symbol.data];
            [self.serviceDispatcher callWithRequest:googleRequest withTarget:self andSelector:@selector(response:)];
        }
    }];
}
-(void)response:(NSNotification *)notification {
    [self stopFullLoading];
    id<REDServiceResponseProtocol> response = [notification object];
    if ([response success]) {
        if ([(NSArray *)[response data] count] == 0) {
            [self showNotificationWithType:SHNotificationViewTypeError withMessage:@"Book not found."];
        } else {
            id<REDBookProtocol> book = [[response data] firstObject];
            REDBookAddViewController *editViewController = [[REDBookAddViewController alloc] initWithBook:book];
            [self.navigationController pushViewController:editViewController animated:YES];
        }
    } else {
        [self showNotificationWithType:SHNotificationViewTypeError withMessage:[[response error] localizedDescription]];
    }
}

#pragma mark - actions
-(void)addAction:(UIBarButtonItem *)addbutton {
    REDNewOptionsViewController *newViewController = [[REDNewOptionsViewController alloc] init];
    [newViewController whatToCreateCallback:^(REDNewOptions option) {
        if (option == REDNewOptionsNewBook) {
            REDBookAddViewController *detailViewController = [[REDBookAddViewController alloc] init];
            [self.navigationController pushViewController:detailViewController animated:YES];
        } else {
            REDAddLogViewController *addLog = [[REDAddLogViewController alloc] init];
            [self.navigationController pushViewController:addLog animated:YES];
        }
    }];
    [self presentViewController:newViewController animated:YES completion:nil];
}
-(void)editAction:(UIBarButtonItem *)editAction {
    [self.libraryCell.libraryView setEditing:!self.libraryCell.libraryView.editing];
    [self.navigationItem setLeftBarButtonItem:self.libraryCell.libraryView.editing ? doneButton : editButton];
}
-(void)barAction:(UIBarButtonItem *)item {
    ZBarReaderViewController *codeReader = [ZBarReaderViewController new];
    codeReader.readerDelegate = self;
    codeReader.view.tintColor = [UIColor red_redColor];
    codeReader.supportedOrientationsMask = ZBarOrientationMaskAll;
    [self presentViewController:codeReader animated:YES completion:nil];
}
-(void)segmentedControlChanged:(UISegmentedControl *)sender {
    [self.navigationItem setLeftBarButtonItem:editButton];
    [self changeType:sender.selectedSegmentIndex];
}
-(void)changeType:(REDLibraryType)type {
    [self.libraryCell.libraryView setType:type];
    [self.segmentedCell changeSelectedSegmentedControl:type];
}

@end
