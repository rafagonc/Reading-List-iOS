//
//  REDLogDatasource.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLogDatasource.h"
#import "REDLogCell.h"

@interface REDLogDatasource ()

@property (nonatomic,strong) NSArray * logs;

@end


@implementation REDLogDatasource

@synthesize delegate;

#pragma mark - getters and setters
-(void)setData:(NSArray *)data {
    _logs = data;
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
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"REDLogCell";
    REDLogCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[REDLogCell alloc] init];
    }
    
    cell.read = self.logs[indexPath.row];
    
    return cell;
}

@end
