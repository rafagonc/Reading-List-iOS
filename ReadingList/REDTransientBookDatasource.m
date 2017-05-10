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
#import "REDTopRatedCell.h"

static NSInteger const REDSearchSection = 1;
static NSInteger const REDTopRatedSection = 0;

@interface REDTransientBookDatasource () <REDTransientBookCellDelegate>

#pragma mark - properties
@property (nonatomic,strong) NSArray * books;
@property (nonatomic,strong) NSArray * topRatedBooks;

@end

@implementation REDTransientBookDatasource

@synthesize delegate;

#pragma mark - setters and getters
-(void)setData:(id)data {
    self.books = data[REDRecommendedBooksViewControllerSearchKey];
    self.topRatedBooks = data[REDRecommendedBooksViewControllerTopRatedKey];
}
-(id)data {
    return self.books;
}

#pragma mark - datasource
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == REDTopRatedSection) {
        return @"Top Rated";
    } else {
        return @"Search";
    }
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == REDSearchSection) {
        return self.books.count == 0 ? 100 : UITableViewAutomaticDimension;
    } else if(indexPath.section == REDTopRatedSection) {
        return 50.f;
    }
    return 50.f;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == REDSearchSection) {
        return self.books.count == 0 ? 1 : self.books.count;
    } else if(section == REDTopRatedSection) {
        return self.topRatedBooks.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = NSStringFromClass([REDTransientBookCell class]);
    NSString *cellIDTopRated = NSStringFromClass([REDTopRatedCell class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexPath.section == REDSearchSection ? cellID : cellIDTopRated];
    if (!cell) {
        cell = indexPath.section == REDSearchSection ? [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([REDTransientBookCell class]) owner:self options:nil] firstObject] :[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([REDTopRatedCell class]) owner:self options:nil] firstObject] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == REDSearchSection) {
        if (self.books.count == 0) {
            return [[[NSBundle mainBundle] loadNibNamed:@"REDExploreTutorialCell" owner:self options:nil] firstObject];
        } else {
            REDTransientBookCell * tCell = (REDTransientBookCell *)cell;
            tCell.book = self.books[indexPath.row];
            tCell.delegate = self;
        }
    } else if(indexPath.section == REDTopRatedSection) {
        REDTopRatedCell * tCell = (REDTopRatedCell *)cell;
        tCell.book = self.topRatedBooks[indexPath.row];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == REDTopRatedSection) {
        [self.delegate datasource:self wantsToCheckOutTopRatedBook:self.topRatedBooks[indexPath.row]];
    }
}

#pragma mark - cell delegate
-(void)transientBookCell:(REDTransientBookCell *)cell wantsToAddTransientBook:(REDTransientBook *)book {
    [self.delegate datasource:self wantsToAddTransientBook:book];
}


@end
