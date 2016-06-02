//
//  REDImportViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/28/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDImportViewController.h"
#import "UIStaticTableView.h"

@interface REDImportViewController ()

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UIStaticTableView *tableView;

#pragma mark - properties

#pragma mark - injected

@end

@implementation REDImportViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super init]) {
        
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Import"];
    [self createTableView];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - table view
-(void)createTableView {
    
    UIStaticTableViewSection * section = [[UIStaticTableViewSection alloc] init];
    [self.tableView addSection:section];
    
    UITableViewCell *dropboxCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    dropboxCell.textLabel.text = @"Dropbox";
    [self.tableView addCell:dropboxCell onSection:section animated:NO];
    
    UITableViewCell *icloudDriveCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    icloudDriveCell.textLabel.text = @"iCloud Drive";
    [self.tableView addCell:icloudDriveCell onSection:section animated:NO];
    
    UITableViewCell *downloadFromLinkCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    downloadFromLinkCell.textLabel.text = @"Download From Link";
    [self.tableView addCell:downloadFromLinkCell onSection:section animated:NO];
    
}

#pragma mark - dealloc
-(void)dealloc {
    
}

@end
