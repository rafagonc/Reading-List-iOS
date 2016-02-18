//
//  REDLogSummaryViewController.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 2/18/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLogSummaryViewController.h"
#import "REDDatasourceProtocol.h"
#import "REDReadProtocol.h"
#import "REDLogDatasourceDelegate.h"
#import "REDBookAddViewController.h"

@interface REDLogSummaryViewController () <REDLogDatasourceDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

#pragma mark - injected
@property (setter=injected_log:, readonly) id<REDDatasourceProtocol> datasource;

#pragma mark - properties
@property (nonatomic,strong) NSArray <id<REDReadProtocol>> * reads;
@property (nonatomic,strong) NSDate * date;

@end

@implementation REDLogSummaryViewController

#pragma mark - constructor
-(instancetype)initWithLogs:(NSArray <id<REDReadProtocol>> *)reads andDate:(NSDate *)date {
    if (self = [super init]) {
        self.reads = reads;
        self.date = date;
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    //title
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    self.title = [dateFormatter stringFromDate:self.date];
    
    //table view
    self.tableView.dataSource = self.datasource;
    self.tableView.delegate = self.datasource;
    [self.datasource setData:self.reads];
    [self.datasource setDelegate:self];
    [self.tableView reloadData];
    
    //summary
    [self setPagesRead:[[self.reads valueForKeyPath:@"@sum.pagesValue"] integerValue]];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - delegate
-(void)datasource:(id<REDDatasourceProtocol>)datasource didDeleteRead:(id<REDReadProtocol>)read {
    
}
-(void)datasource:(id<REDDatasourceProtocol>)datasource wantsToCheckOutBook:(id<REDBookProtocol>)book {
    REDBookAddViewController *bookViewController = [[REDBookAddViewController alloc] initWithBook:book];
    [self.navigationController pushViewController:bookViewController animated:YES];
}
-(BOOL)datasourceCanDeleteLogs:(id<REDDatasourceProtocol>)datasource {
    return NO;
}

#pragma mark - setters
-(void)setPagesRead:(NSInteger)pagesRead {
    [self.summaryLabel setText:[NSString stringWithFormat:@"You read a total of %lu pages", pagesRead]];
}

#pragma mark - dealloc
-(void)dealloc {
    
}

@end
