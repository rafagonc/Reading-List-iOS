//
//  REDTransientBookDatasource.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/26/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDTransientBookDatasource.h"
#import "REDTransientBookCell.h"
#import "REDTransientBookDatasourceDelegate.h"

@interface REDTransientBookDatasource () <REDTransientBookCellDelegate>

#pragma mark - properties
@property (nonatomic,strong) NSArray * books;

@end

@implementation REDTransientBookDatasource

@synthesize delegate;

#pragma mark - setters and getters
-(void)setData:(NSArray *)data {
    self.books = data;
}
-(NSArray *)data {
    return self.books;
}

#pragma mark - datasource
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.books.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = NSStringFromClass([REDTransientBookCell class]);
    REDTransientBookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellID owner:self options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.book = self.books[indexPath.row];
    cell.delegate = self;
    
    return cell;
}

#pragma mark - cell delegate
-(void)transientBookCell:(REDTransientBookCell *)cell wantsToAddTransientBook:(REDTransientBook *)book {
    [self.delegate datasource:self wantsToAddTransientBook:book];
}


@end
