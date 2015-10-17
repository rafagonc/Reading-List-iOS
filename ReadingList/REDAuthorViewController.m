//
//  REDAuthorViewController.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/15/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDAuthorViewController.h"
#import "REDDatasourceProtocol.h"
#import "REDEntityFetcher.h"
#import "REDAuthorCreateViewController.h"

@interface REDAuthorViewController () <UITableViewDelegate>

#pragma mark - ui
@property (weak, nonatomic) IBOutlet UITableView *tableView;

#pragma mark - injected
@property (setter=injected_author:,readonly) id<REDDatasourceProtocol> datasource;

@end

@implementation REDAuthorViewController

#pragma mark - constructor
-(instancetype)init {
    if (self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil]) {
        
    } return self;
}

#pragma mark  - lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Authors";
    
    self.tableView.dataSource = self.datasource;
    self.tableView.delegate=  self;
    
    [self updateData];
}

#pragma mark - methods
-(void)updateData {
    [self.datasource setData:[[[REDEntityFetcher withProtocol:@protocol(REDAuthorProtocol)] setSortDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]] all]];
}

#pragma mark - table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    id<REDAuthorProtocol> author;
    if (indexPath.section) {
        author = [self.datasource data][indexPath.row];
        if (self.callback)self.callback(author);
        self.callback = nil;
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        REDAuthorCreateViewController *createAuthor = [[REDAuthorCreateViewController alloc] init];
        createAuthor.callback = ^(id<REDAuthorProtocol> author) {
            if (self.callback) self.callback(author);
            [self.navigationController popViewControllerAnimated:YES];
        };
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:createAuthor] animated:YES completion:nil];
    }

}

#pragma mark - dealloc
-(void)dealloc {

}

@end