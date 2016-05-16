//
//  REDRLMBookDataAccessObject.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/3/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMBookDataAccessObject.h"
#import "REDRLMBook.h"
#import "REDRLMArrayHelper.h"

@interface REDRLMBookDataAccessObject ()

@property (setter=injected:) id<REDRLMArrayHelper> rlm_arrayHelper;

@end

@implementation REDRLMBookDataAccessObject

#pragma mark - creating
-(id)create {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    REDRLMBook * book = [[REDRLMBook alloc] init];
    [realm addObject:book];
    [realm commitWriteTransaction];
    return book;
}
-(id<REDBookProtocol>)createFromDictionary:(NSDictionary *)dict {
    id<REDBookProtocol> book = [self create];
    [self updateBook:book withDict:dict];
    return book;
}

#pragma mark - update
-(id<REDBookProtocol>)updateBook:(id<REDBookProtocol>)book withDict:(NSDictionary *)dict {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [book setName:dict[@"book"][@"name"]];
    [book setRate:[dict[@"rate"] doubleValue]];
    [book setSnippet:dict[@"snippet"]];
    [book setIdentifier:[dict[@"id"] integerValue]];
    [book setLoved:dict[@"loved"]];
    [book setPagesValue:[dict[@"pages"] integerValue]];
    [book setPagesReadValue:[dict[@"pages_read"] integerValue]];
    [book setUnprocessed:NO];
    [realm commitWriteTransaction];
    return book;
}

#pragma mark - queries
-(id)list {
    return [self.rlm_arrayHelper arrayFromResults:[REDRLMBook allObjects]];
}
-(id)listWithPredicate:(NSPredicate *)predicate {
    return [[self list] filteredArrayUsingPredicate:predicate];
}

#pragma mark - specific queries
-(NSArray<id<REDBookProtocol>> *)searchBooksWithString:(NSString *)name {
    NSArray * books = [self listWithPredicate:[NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@ OR category.name BEGINSWITH[cd] %@ OR author.name BEGINSWITH[cd] %@", name, name, name]];
    return (NSArray *)[books sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"completed" ascending:YES]]];
}
-(NSArray<id<REDBookProtocol>> *)searchBooksWithIdentifier:(NSInteger)identifier {
    return [self listWithPredicate:[NSPredicate predicateWithFormat:@"identifier = %d",identifier]];
}
-(NSArray <id<REDBookProtocol>> *)allBooksSorted {
    return (NSArray *)[[self list] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"completed" ascending:YES],[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
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
    NSArray <id<REDBookProtocol>> * books = [self list];
    NSUInteger booksCompleted = [books filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"completed = 1"]].count;
    return [NSString stringWithFormat:@"%lu/%lu books completed", (unsigned long)booksCompleted, (unsigned long)books.count];
}

@end
