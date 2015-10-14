//
//  REDCategoryDatasource.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/14/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDCategoryDatasource.h"
#import "REDCategoryProtocol.h"
#import "UIFont+ReadingList.h"

@interface REDCategoryDatasource ()

#pragma mark - properties
@property (nonatomic,strong) NSArray *categories;

#pragma mark - ui
@property (nonatomic,weak) UITableView *tableView;

@end

@implementation REDCategoryDatasource

#pragma mark - getters and setters
-(void)setData:(NSArray *)data {
    _categories = data;
    [self.tableView reloadData];
}
-(NSArray *)data {
    return _categories;
}

#pragma mark - table view datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView = tableView;
    return self.categories.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"REDCategoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell.textLabel setFont:[UIFont AvenirNextBoldWithSize:14.0f]];
    }
    
    id<REDCategoryProtocol> category = self.categories[indexPath.row];
    cell.textLabel.text = [category name];
    return cell;
}

@end
