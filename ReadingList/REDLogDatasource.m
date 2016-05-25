//
//  REDLogDatasource.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLogDatasource.h"
#import "REDLogCell.h"
#import "REDReadDataAccessObject.h"
#import "REDReadProtocol.h"
#import "REDLogCellDelegate.h"
#import "REDLogDatasourceDelegate.h"

@interface REDLogDatasource ()

<REDLogCellDelegate>

#pragma mark - injected
@property (setter=injected:) id<REDReadDataAccessObject> readDataAccessObject;

#pragma mark - properties
@property (nonatomic,strong) NSMutableArray * logs;

@end


@implementation REDLogDatasource

@synthesize delegate;

#pragma mark - getters and setters
-(void)setData:(NSArray *)data {
    _logs = [data mutableCopy];
}
-(NSArray *)data {
    return _logs;
}

#pragma mark - table view datasource and delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90.0f;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.logs count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"REDLogCell";
    REDLogCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[REDLogCell alloc] init];
    }
    if (indexPath.row < self.logs.count) {
        cell.read = self.logs[indexPath.row];
        cell.delegate = self;
    }
    
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.delegate datasourceCanDeleteLogs:self];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        id<REDReadProtocol> read = self.logs[indexPath.row];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.delegate datasource:self didDeleteRead:read];
        [tableView endUpdates];
    }
}
-(void)logCell:(REDLogCell *)logCell wantsToCheckOutBook:(id<REDBookProtocol>)book {
    [self.delegate datasource:self wantsToCheckOutBook:book];
}

@end
