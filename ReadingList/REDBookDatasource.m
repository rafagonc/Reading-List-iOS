//
//  SHBookListDatasource.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookDatasource.h"
#import "REDBookCell.h"
#import "REDBookAddViewController.h"
#import "UIFont+ReadingList.h"
#import "REDBookDatasourceDelegate.h"
#import "REDBookDataAccessObject.h"
#import "UITableViewCell+Clear.h"

@interface REDBookDatasource () {
}

#pragma mark - ui
@property (nonatomic,weak) UITableView *tableView;

#pragma mark - properties
@property (nonatomic,strong) NSArray *books;

#pragma mark - injected
@property (setter=injected:,readonly) id<REDBookDataAccessObject> bookDataAccessObject;

@end

@implementation REDBookDatasource

@synthesize delegate;

#pragma mark - properties
-(void)setData:(NSArray *)data {
    _books = [data copy];
}
-(NSArray *)data {
    return _books;
}

#pragma mark - table view datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    _tableView = tableView;
    return self.books.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = NSStringFromClass([REDBookCell class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexPath.section == 0 ? cellID : @"CellID"];
    if (!cell) {
        cell =  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([REDBookCell class]) owner:self options:nil] firstObject];
        [cell clearBackgroundSelection];
    }
    
    REDBookCell *bookCell = (REDBookCell *)cell;
    bookCell.book = self.books[indexPath.row];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.delegate datasource:self didSelectBook:self.books[indexPath.row]];
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.bookDataAccessObject remove:self.books[indexPath.row]];
        [self.delegate datasource:self didDeleteBook:self.books[indexPath.row]];
    }
}

@end
