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
    NSArray * books = [self listWithPredicate:[NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", name]];
    return [books sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"completed" ascending:YES]]];
}
-(NSArray <id<REDBookProtocol>> *)allBooksSorted {
    return [[self list] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"completed" ascending:YES],[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
}
-(NSUInteger)totalPages {
    NSUInteger totalPages = 0;
    NSArray <id<REDBookProtocol>> * books = [self list];
    for (id<REDBookProtocol> book in books) {
        totalPages += [book pagesReadValue];
    }
    return totalPages;
}

#pragma mark - overrides
-(NSString *)entityName {
    return @"REDBook";
}

@end
