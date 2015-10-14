//
//  REDCategoryViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/14/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDCategoryViewController.h"
#import "REDDatasourceProtocol.h"
#import "REDEntityFetcher.h"

@interface REDCategoryViewController () <UITableViewDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITableView *tableView;

#pragma mark - injected
@property (setter=injected_category:, readonly) id<REDDatasourceProtocol> datasource;

@end

@implementation REDCategoryViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        
    } return self;
}

#pragma mark - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self.datasource;
    self.tableView.delegate = self;
    
    [self updateData];
}

#pragma mark - methods
-(void)updateData {
    [self.datasource setData:[[[REDEntityFetcher withProtocol:@protocol(REDCategoryProtocol)] setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]] all]];
}

#pragma mark - table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id<REDCategoryProtocol> category = [self.datasource data][indexPath.row];
    if (self.callback) self.callback(category);
    self.callback = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - dealloc
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)dealloc {
    
}



@end