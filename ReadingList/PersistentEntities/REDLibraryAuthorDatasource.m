//
//  REDLibraryAuthorDatasource.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/10/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDLibraryAuthorDatasource.h"
#import "REDAuthorProtocol.h"
#import "UIFont+ReadingList.h"
#import "UITableViewCell+Clear.h"
#import "REDAuthorDatasourceDelegate.h"
#import "REDAuthorCell.h"

@interface REDLibraryAuthorDatasource () <REDAuthorCellDelegate>

#pragma mark - properties
@property (nonatomic,strong) NSArray *authors;

#pragma mark - ui
@property (nonatomic,weak) UITableView *tableView;


@end

@implementation REDLibraryAuthorDatasource

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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView = tableView;
    return self.authors.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"REDAuthorCell";
    REDAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([REDAuthorCell class]) owner:self options:nil] firstObject];
        [cell.textLabel setFont:[UIFont AvenirNextRegularWithSize:14.0f]];
        [cell clearBackgroundSelection];
    }
    
    
    id<REDAuthorProtocol> author = self.authors[indexPath.row];
    cell.author = author;
    cell.delegate = self;
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.delegate authorDatasource:self wantsToDeleteAuthor:self.authors[indexPath.row]];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate authorDatasource:self didSelectAuthor:self.authors[indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - delegate
-(void)authorCell:(REDAuthorCell *)cell wantsToEditAuthor:(id<REDAuthorProtocol>)author {
    [self.delegate authorDatasource:self wantsToEditAuthor:author];
}

@end
