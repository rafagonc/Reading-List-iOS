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
#import "REDEntityRemover.h"
#import "REDBookDatasourceDelegate.h"
#import "UITableViewCell+Clear.h"

@interface REDBookDatasource () {
}

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSArray *books;

@end

@implementation REDBookDatasource

@synthesize delegate;

#pragma mark - properties
-(void)setData:(NSArray *)data {
    _books = [data copy];
    [_tableView reloadData];
}
-(NSArray *)data {
    return _books;
}

#pragma mark - table view datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0 ? 80 : 50;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    _tableView = tableView;
    return section == 0 ? self.books.count : 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = NSStringFromClass([REDBookCell class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexPath.section == 0 ? cellID : @"CellID"];
    if (!cell) {
        cell =  indexPath.section == 0 ?[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([REDBookCell class]) owner:self options:nil] firstObject] : [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
        [cell clearBackgroundSelection];
    }
    
    if (indexPath.section == 0) {
        REDBookCell *bookCell = (REDBookCell *)cell;
        bookCell.book = self.books[indexPath.row];
    } else {
        cell.textLabel.text = @"New Book";
        cell.textLabel.font = [UIFont AvenirNextRegularWithSize:15.0f];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.delegate datasource:self didSelectBook:self.books[indexPath.row]];
    } else {
        [self.delegate datasourceWantsToAddNewBook:self];
    }
    
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == 0;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [REDEntityRemover removeObject:self.books[indexPath.row]];
        [self.delegate datasource:self didDeleteBook:self.books[indexPath.row]];
    }
}

@end
