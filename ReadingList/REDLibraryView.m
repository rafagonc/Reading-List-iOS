//
//  REDLibraryView.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 7/17/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLibraryView.h"
#import "REDServiceDispatcherProtocol.h"
#import "REDBookDataAccessObject.h"
#import "REDLibraryDatasourceFactory.h"
#import "REDLibraryDataProvider.h"
#import "REDAuthorRemover.h"
#import "REDUserProtocol.h"
#import "REDBookRepositoryFactory.h"
#import "UISearchBar+Toolbar.h"
#import "REDLibraryViewController_Constants.h"
#import "REDLibraryDataProvider.h"
#import "REDAuthorCreateViewController.h"
#import "REDBookPredicateViewController.h"
#import "REDBookDatasourceDelegate.h"
#import "REDAuthorDatasourceDelegate.h"
#import "REDCategoryDatasourceDelegate.h"
#import "REDLogDatasourceDelegate.h"
#import "REDCategoryRemover.h"

@interface REDLibraryView () <REDBookDatasourceDelegate, UISearchBarDelegate, REDAuthorDatasourceDelegate, REDCategoryDatasourceDelegate, REDLogDatasourceDelegate>


#pragma mark - properties
@property (nonatomic,strong) id<REDBookRepository> bookRepository;
@property (nonatomic,strong) NSString * searchText;

#pragma mark - injected
@property (setter=injected1:) id<REDBookDataAccessObject> bookDataAccessObject;
@property (setter=injected2:) id<REDBookRepositoryFactory> bookRepositoryFactory;
@property (setter=injected3:) id<REDUserProtocol> user;
@property (setter=injected4:) id<REDLibraryDatasourceFactory> libraryDatasourceFactory;
@property (setter=injected5:) id<REDServiceDispatcherProtocol> serviceDispatcher;
@property (setter=injected6:) id<REDAuthorRemover> authorRemover;
@property (setter=injected7:) id<REDCategoryRemover> categoryRemover;

@end

@implementation REDLibraryView

#pragma mark - override
-(void)awakeFromNib {
    [super awakeFromNib];
    
    self.type = REDLibraryTypeBooks;
    
    self.datasource = [self.libraryDatasourceFactory datasourceForType:REDLibraryTypeBooks];
    self.tableView.delegate = self.datasource;
    self.tableView.dataSource = self.datasource;
    self.tableView.scrollEnabled = NO;
    [self.datasource setDelegate:self];
    [self updateDataWithType:self.type sync:NO];
    [self.tableView reloadData];
    
}

#pragma mark - search bar protocol
-(BOOL)isSearcingBooks {
    return self.searchText.length > 0;
}

#pragma mark - setter
-(void)setType:(REDLibraryType)type {
    [self setType:type andSync:NO];
}
-(void)setType:(REDLibraryType)type andSync:(BOOL)sync {
    _type = type;
    
    self.datasource = [self.libraryDatasourceFactory datasourceForType:self.type];
    self.tableView.delegate = self.datasource;
    self.tableView.dataSource = self.datasource;
    [self.datasource setDelegate:self];
    [self.tableView reloadData];
    
    [self updateDataWithType:self.type sync:sync];
}
-(void)setEditing:(BOOL)editing {
    _editing = editing;
    [self.tableView setEditing:editing animated:YES];
    [self.datasourceDelegate libraryView:self datasource:self.datasource didChangeEditing:editing];
}
-(void)setSearchText:(NSString *)searchText {
    _searchText = searchText;
    [self updateDataWithType:self.type sync:NO];
}

#pragma mark - delegates
-(void)datasource:(id<REDDatasourceProtocol>)datasource didSelectBook:(id<REDBookProtocol>)book {
    [self.datasourceDelegate libraryView:self datasource:self.datasource didSelectBook:book error:nil];
}
-(void)datasource:(id<REDDatasourceProtocol>)datasource didDeleteBook:(id<REDBookProtocol>)book {
    self.bookRepository = [self.bookRepositoryFactory repository];
    [self.bookRepository removeForUser:self.user book:book callback:^() {
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.datasource.data indexOfObject:book] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self updateDataWithType:self.type sync:YES];
        [self.tableView endUpdates];
        [self.datasourceDelegate libraryView:self datasource:datasource didDeleteBook:book error:nil];
    } error:^(NSError *error) {
        [self.datasourceDelegate libraryView:self datasource:datasource didDeleteBook:book error:error];
    }];
}
-(BOOL)datasourceCanEditBooks:(id<REDDatasourceProtocol>)datasource {
    return YES;
}
-(BOOL)datasourceShouldShowAccessoryType:(id<REDDatasourceProtocol>)datasource {
    return YES;
}
-(void)authorDatasource:(id<REDDatasourceProtocol>)authorDatasource didSelectAuthor:(id<REDAuthorProtocol>)author {
    [self.datasourceDelegate libraryView:self datasource:authorDatasource didSelectAuthor:author error:nil];
}
-(void)authorDatasource:(id<REDDatasourceProtocol>)authorDatasource wantsToDeleteAuthor:(id<REDAuthorProtocol>)author {
    __weak typeof(self) welf = self;
    [self.authorRemover removeAuthor:author withCallback:^{
        [welf updateDataWithType:REDLibraryTypeAuthor sync:YES];
    }];
}
-(void)authorDatasource:(id<REDDatasourceProtocol>)authorDatasource wantsToEditAuthor:(id<REDAuthorProtocol>)author {
    [self.datasourceDelegate libraryView:self datasource:authorDatasource wantsToEditAuthor:author error:nil];
}
-(void)categoryDatasource:(id<REDDatasourceProtocol>)datasource didSelectCategory:(id<REDCategoryProtocol>)category {
    [self.datasourceDelegate libraryView:self datasource:datasource didSelectCategory:category error:nil];
}
-(BOOL)datasourceCanDeleteLogs:(id<REDDatasourceProtocol>)datasource {
    return YES;
}
-(void)datasource:(id<REDDatasourceProtocol>)datasource wantsToCheckOutBook:(id<REDBookProtocol>)book {
    [self datasource:datasource didSelectBook:book];
}
-(void)datasource:(id<REDDatasourceProtocol>)datasource didDeleteRead:(id)read {
    [self updateDataWithType:self.type sync:YES];
}
-(void)categoryDatasource:(id<REDDatasourceProtocol>)datasource wantsToEditCategory:(id<REDCategoryProtocol>)category {
    [self.datasourceDelegate libraryView:self datasource:datasource wantsToEditCategory:category error:nil];
}
-(void)categoryDatasource:(id<REDDatasourceProtocol>)datasource wantsToDelete:(id<REDCategoryProtocol>)category {
    __weak typeof(self) welf = self;
    [self.categoryRemover removeCategory:category withCallback:^{
        [welf updateDataWithType:REDLibraryTypeCategories sync:YES];
    }];
}

#pragma mark - searching
-(void)pleaseSirSearchForThisBooks:(NSString *)searchText {
    [self setSearchText:searchText];
}
-(void)stopSearchNowSir {
    [self setSearchText:nil];
    [self updateDataWithType:self.type sync:NO];
}

#pragma mark - methods
-(void)updateDataWithType:(REDLibraryType)type sync:(BOOL)sync {
    NSError * error;
    if ([self isSearcingBooks]) {
        [[REDLibraryDataProvider new] dataForType:type withNameFilter:[self.searchText copy] callback:^(id data) {
            [self.datasource setData:data];
            [self.tableView reloadData];
            [self.delegate libraryViewDidUpdate:self];
        } error:&error];
    } else {
        [[REDLibraryDataProvider new] dataForType:type sync:sync callback:^(id data) {
            [self.datasource setData:data];
            [self.tableView reloadData];
            [self.delegate libraryViewDidUpdate:self];
        } error:&error];
    }
}
-(void)update {
    [self updateDataWithType:self.type sync:NO];
}
-(void)sync {
    [self updateDataWithType:self.type sync:YES];
}


@end
