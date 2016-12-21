//
//  REDAddViewController.m
//  ReadingList
//
//  Created by Banco Santander Brasil on 12/21/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDAddViewController.h"
#import "UIStaticTableView.h"
#import "REDSelectCell.h"
#import "REDExploreViewController.h"
#import "ZBarReaderViewController.h"
#import "UIColor+ReadingList.h"
#import "REDBookAddViewController.h"
#import "REDAddLogViewController.h"

@interface REDAddViewController ()

<ZBarReaderDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIStaticTableView *tableView;

#pragma mark - properties
@property (weak, nonatomic) id<ZBarReaderDelegate> zbarDelegate;

@end

@implementation REDAddViewController

#pragma mark - constructor
-(instancetype)initWithDelegate:(id<ZBarReaderDelegate>)zbarDelegate {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil] ) {
        self.zbarDelegate = zbarDelegate;
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - create table view
-(void)createTableView {
    
    __weak typeof(self) welf = self;
    
    UIStaticTableViewSection * bookSection = [[UIStaticTableViewSection alloc] init];
    [bookSection setHeaderName:@"Adding Books"];
    
    REDSelectCell * searchBookCell = [[REDSelectCell alloc] initWithTitle:@"By Name"];
    [searchBookCell handleSelection:^{
        REDExploreViewController * explore = [[REDExploreViewController alloc] init];
        [welf.navigationController pushViewController:explore animated:YES];
    }];
    [self.tableView addCell:searchBookCell onSection:bookSection];
    
    REDSelectCell * scanBarcodeCell = [[REDSelectCell alloc] initWithTitle:@"By ISBN"];
    [scanBarcodeCell handleSelection:^{
        ZBarReaderViewController *codeReader = [ZBarReaderViewController new];
        codeReader.readerDelegate = welf.zbarDelegate;
        codeReader.view.tintColor = [UIColor red_redColor];
        codeReader.supportedOrientationsMask = ZBarOrientationMaskAll;
        [welf presentViewController:codeReader animated:YES completion:nil];
    }];
    [self.tableView addCell:scanBarcodeCell onSection:bookSection];
    
    REDSelectCell * manualCell = [[REDSelectCell alloc] initWithTitle:@"Manually"];
    [manualCell handleSelection:^{
        REDBookAddViewController * add = [[REDBookAddViewController alloc] init];
        [welf.navigationController pushViewController:add animated:YES];
    }];
    [self.tableView addCell:manualCell onSection:bookSection];
    
    UIStaticTableViewSection * logSection = [[UIStaticTableViewSection alloc] init];
    [logSection setHeaderName:@"Adding Logs"];
    
    REDSelectCell * addLogCell = [[REDSelectCell alloc] initWithTitle:@"Manually"];
    [addLogCell handleSelection:^{
        REDAddLogViewController * addLog = [[REDAddLogViewController alloc] init];
        [welf.navigationController pushViewController:addLog animated:YES];
    }];
    [self.tableView addCell:addLogCell onSection:logSection];
    
    [self.tableView addSection:bookSection];
    [self.tableView addSection:logSection];
    
}

#pragma mark - dealloc
-(void)dealloc {
    
}

@end
