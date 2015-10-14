//
//  SHBookListDatasource.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 10/13/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookDatasource.h"
#import "REDBookCell.h"

@interface REDBookDatasource () {
}

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSArray *books;

@end

@implementation REDBookDatasource


#pragma mark - properties
-(void)setData:(NSArray *)data {
    _books = [data copy];
    [_tableView reloadData];
}
-(NSArray *)data {
    return _books;
}

#pragma mark - table view datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    _tableView = tableView;
    return self.books.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = NSStringFromClass([REDBookCell class]);
    REDBookCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([REDBookCell class]) owner:self options:nil] firstObject];
    }
    
    cell.book = self.books[indexPath.row];
    
    return cell;
}

@end
