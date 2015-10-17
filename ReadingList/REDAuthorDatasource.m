//
//  REDAuthorDatasource.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/15/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDAuthorDatasource.h"
#import "REDAuthorProtocol.h"
#import "UIFont+ReadingList.h"
#import "UITableViewCell+Clear.h"

@interface REDAuthorDatasource ()

#pragma mark - properties
@property (nonatomic,strong) NSArray *authors;

#pragma mark - ui
@property (nonatomic,weak) UITableView *tableView;

@end

@implementation REDAuthorDatasource

@synthesize delegate;

#pragma mark - getters and setters
-(void)setData:(NSArray *)data {
    _authors = data;
    [self.tableView reloadData];
}
-(NSArray *)data {
    return _authors;
}

#pragma mark - table view datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView = tableView;
    return section ? self.authors.count : 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"REDAuthorCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell.textLabel setFont:[UIFont AvenirNextRegularWithSize:14.0f]];
        [cell clearBackgroundSelection];
    }
    
    if (indexPath.section) {
        id<REDAuthorProtocol> author = self.authors[indexPath.row];
        cell.textLabel.text = [author name];
    } else {
        cell.textLabel.text = @"New Author";
    }
    
    return cell;
}


@end
