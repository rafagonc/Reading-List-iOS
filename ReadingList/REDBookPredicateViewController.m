//
//  REDBookPredicateViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/10/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDBookPredicateViewController.h"
#import "REDBookProtocol.h"
#import "REDBookDataAccessObject.h"
#import "REDDatasourceProtocol.h"
#import "REDNavigationBarCustomizer.h"
#import "REDBookDatasourceDelegate.h"
#import "REDBookAddViewController.h"

@interface REDBookPredicateViewController () <REDBookDatasourceDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

#pragma mark - injected
@property (setter=injected1:) id<REDBookDataAccessObject> bookDataAccessObject;
@property (setter=injected_book:) id<REDDatasourceProtocol> datasource;

#pragma mark - properties
@property (nonatomic,strong) NSArray <id<REDBookProtocol>> * books;

@end

@implementation REDBookPredicateViewController

#pragma mark - constructor
-(instancetype)init {
    return [self initWithPrediate:nil];
}
-(instancetype)initWithPrediate:(NSPredicate *)predicate {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        if (predicate) {
            self.books = [self.bookDataAccessObject listWithPredicate:predicate];
        } else {
            self.books = [self.bookDataAccessObject allBooksSorted];
        }
    } return self;
}
-(instancetype)initWithBooks:(NSArray <id<REDBookProtocol>> *)books {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        [self.datasource setData:books];
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [REDNavigationBarCustomizer customizeNavigationBar:self.navigationController.navigationBar];
    [self.datasource setData:self.books];
    [self.datasource setDelegate:self];
    [self.tableView setDataSource:self.datasource];
    [self.tableView setDelegate:self.datasource];
    [self.tableView reloadData];
    
    if ([self.books count] == 0) {
        [self.countLabel setText:[NSString stringWithFormat:@"No books were found"]];
    } else if ([self.books count] == 1) {
        [self.countLabel setText:[NSString stringWithFormat:@"1 Book"]];
    } else {
        [self.countLabel setText:[NSString stringWithFormat:@"%lu books", [self.books count]]];
    }
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.datasource setData:self.books];
    [self.tableView reloadData];
}

#pragma mark - datasource delegate
-(void)datasource:(id<REDDatasourceProtocol>)datasource didDeleteBook:(id<REDBookProtocol>)book {
    
}
-(void)datasource:(id<REDDatasourceProtocol>)datasource didSelectBook:(id<REDBookProtocol>)book {
    REDBookAddViewController *add = [[REDBookAddViewController alloc] initWithBook:book];
    [self.navigationController pushViewController:add animated:YES];
}
-(BOOL)datasourceCanEditBooks:(id<REDDatasourceProtocol>)datasource {
    return NO;
}
-(BOOL)datasourceShouldShowAccessoryType:(id<REDDatasourceProtocol>)datasource {
    return YES;
}

#pragma mark - setters
-(void)setNavigationBarTitle:(NSString *)title {
    self.title = title;
}

-(void)dealloc {
    
}

@end
