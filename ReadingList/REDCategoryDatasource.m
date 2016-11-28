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
#import "UITableViewCell+Clear.h"
#import "REDCategoryDatasourceDelegate.h"
#import "REDCategoryCell.h"

@interface REDCategoryDatasource () <REDCategoryCellDelegate>

#pragma mark - properties
@property (nonatomic,strong) NSArray *categories;

#pragma mark - ui
@property (nonatomic,weak) UITableView *tableView;

@end

@implementation REDCategoryDatasource

@synthesize delegate;

#pragma mark - getters and setters
-(void)setData:(NSArray *)data {
    _categories = data;
    [self.tableView reloadData];
}
-(NSArray *)data {
    return _categories;
}

#pragma mark - table view datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView = tableView;
    return self.categories.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"REDCategoryCell";
    REDCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([REDCategoryCell class]) owner:self options:nil] firstObject];
        [cell.textLabel setFont:[UIFont AvenirNextRegularWithSize:14.0f]];
        [cell clearBackgroundSelection];
    }
    
    cell.category = self.categories[indexPath.row];
    cell.delegate = self;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate categoryDatasource:self didSelectCategory:self.categories[indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[self.categories objectAtIndex:indexPath.row] custom];
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.delegate categoryDatasource:self wantsToDelete:self.categories[indexPath.row]];
    }
}

#pragma mark - cell delegate
-(void)categoryCellWantsToEditCategory:(REDCategoryCell *)categoryCell {
    [self.delegate categoryDatasource:self wantsToEditCategory:categoryCell.category];
}

@end
