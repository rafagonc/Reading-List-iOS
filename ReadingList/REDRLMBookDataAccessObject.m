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
#import "REDAuthorDataAccessObject.h"
#import "REDCategoryDataAccessObject.h"
#import "REDTransactionManager.h"

@interface REDRLMBookDataAccessObject ()

@property (setter=injected1:) id<REDRLMArrayHelper> rlm_arrayHelper;
@property (setter=injected4:) id<REDTransactionManager> transactionManager;
@property (setter=injected2:) id<REDAuthorDataAccessObject> authorDataAccessObject;
@property (setter=injected3:) id<REDCategoryDataAccessObject> categoryDataAccessObject;


@end

@implementation REDRLMBookDataAccessObject

#pragma mark - creating
-(id)create {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    REDRLMBook * book = [[REDRLMBook alloc] init];
    [book setPagesValue:0];
    [book setPagesReadValue:0];
    [book setLoved:0];
    [book setSnippet:@""];
    [book setRate:0.0];
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
    [self.transactionManager begin];
    [book setName:dict[@"book"][@"name"]];
    [self.transactionManager commit];
    NSString * authorName = dict[@"book"][@"author"][@"name"];
    id<REDAuthorProtocol> author = [self.authorDataAccessObject authorByName:authorName];
    if (!author) {
        author = [self.authorDataAccessObject create];
        [self.transactionManager begin];
        [author setName:authorName];
        [self.transactionManager commit];
    }
    [self.transactionManager begin];
    [book setAuthor:author];
    
    NSString * categoryName = dict[@"book"][@"category"][@"name"];
    id<REDCategoryProtocol> category = [self.categoryDataAccessObject categoryByName:categoryName];
    [book setCategory:category];
    
    [book setRate:[dict[@"rate"] doubleValue]];
    [book setSnippet:dict[@"snippet"]];
    [book setIdentifier:[dict[@"id"] integerValue]];
    if ([[dict objectForKey:@"loved"] isEqual:[NSNull null]] == NO) [book setLoved:[dict[@"loved"] boolValue]];
    [book setPagesValue:[dict[@"pages"] integerValue]];
    [book setPagesReadValue:[dict[@"pages_read"] integerValue]];
    [book setCoverURL:[[dict objectForKey:@"cover_url"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"cover_url"]];
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
    return (NSArray *)[[self listWithPredicate:[NSPredicate predicateWithBlock:^BOOL(id<REDBookProtocol>  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [[evaluatedObject name] length] > 0;
    }]] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"completed" ascending:YES],[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
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
