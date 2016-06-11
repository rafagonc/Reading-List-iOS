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

@interface REDLibraryAuthorDatasource ()

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        [cell.textLabel setFont:[UIFont AvenirNextRegularWithSize:14.0f]];
        [cell clearBackgroundSelection];
    }
    
    
    id<REDAuthorProtocol> author = self.authors[indexPath.row];
    cell.textLabel.text = [author name];
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate authorDatasource:self didSelectAuthor:self.authors[indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
