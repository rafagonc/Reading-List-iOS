//
//  REDBookDataAccessObjectImpl.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDBookDataAccessObjectImpl.h"

@implementation REDBookDataAccessObjectImpl


#pragma mark - methods
-(NSArray<id<REDBookProtocol>> *)searchBooksWithString:(NSString *)name {
    NSArray * books = [self listWithPredicate:[NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@ AND unprocessed = NO", name]];
    return [books sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"completed" ascending:YES]]];
}
-(NSArray <id<REDBookProtocol>> *)allBooksSorted {
    return [[[self list] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"unprocessed = NO"]] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"completed" ascending:YES],[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
}
-(id<REDBookProtocol>)createFromTransientBook:(REDTransientBook *)transientBook {
    return [self create];
}
-(NSUInteger)totalPages {
    NSUInteger totalPages = 0;
    NSArray <id<REDBookProtocol>> * books = [self list];
    for (id<REDBookProtocol> book in books) {
        totalPages += [book pagesReadValue];
    }
    return totalPages;
}
-(NSString *)booksCompletedAndTotalBooks {
    return nil;
}
-(id<REDBookProtocol>)updateBook:(id<REDBookProtocol>)book withDict:(NSDictionary *)dict {
    return book;
}
-(id<REDBookProtocol>)createFromDictionary:(NSDictionary *)dict {
    return [self create];
}
-(NSArray<id<REDBookProtocol>> *)searchBooksWithIdentifier:(NSInteger)identifier {
    return nil;
}

#pragma mark - overrides
-(NSString *)entityName {
    return @"REDBook";
}

@end
