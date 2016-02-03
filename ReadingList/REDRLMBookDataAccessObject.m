//
//  REDRLMBookDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMBookDataAccessObject.h"
#import "REDRLMBook.h"

@implementation REDRLMBookDataAccessObject

#pragma mark - creating
-(id)create {
    return [[REDRLMBook alloc] init];
}

#pragma mark - queries
-(NSArray *)list {
    return (NSArray *)[REDRLMBook allObjects];
}
-(NSArray *)listWithPredicate:(NSPredicate *)predicate {
    return (NSArray *)[REDRLMBook objectsWithPredicate:predicate];
}

#pragma mark - specific queries
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

@end
