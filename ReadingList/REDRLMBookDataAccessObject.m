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
#import "REDTransientBook.h"
#import "REDTransactionManager.h"
#import "REDBookRepositoryFactory.h"
#import "REDUserProtocol.h"
#import "REDRLMNote.h"
#import "REDNotesProtocol.h"
#import "REDNotesDataAccessObject.h"

@interface REDRLMBookDataAccessObject ()

@property (setter=injected7:) id<REDNotesDataAccessObject> notesDataAccessObject;
@property (setter=injected6:) id<REDUserProtocol> user;
@property (setter=injected5:) id<REDBookRepositoryFactory> bookRepositoryFactory;
@property (setter=injected1:) id<REDRLMArrayHelper> rlm_arrayHelper;
@property (setter=injected4:) id<REDTransactionManager> transactionManager;
@property (setter=injected2:) id<REDAuthorDataAccessObject> authorDataAccessObject;
@property (setter=injected3:) id<REDCategoryDataAccessObject> categoryDataAccessObject;

@end

@implementation REDRLMBookDataAccessObject

#pragma mark - creating
-(id)create {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [self.transactionManager begin];
    REDRLMBook * book = [[REDRLMBook alloc] init];
    [book setPagesValue:0];
    [book setPagesReadValue:0];
    [book setLoved:0];
    [book setSnippet:@""];
    [book setRate:0.0];
    [realm addObject:book];
    [self.transactionManager commit];
    return book;
}
-(id<REDBookProtocol>)createFromDictionary:(NSDictionary *)dict {
    id<REDBookProtocol> book = [self create];
    [self updateBook:book withDict:dict];
    return book;
}
-(id<REDBookProtocol>)createFromTransientBook:(REDTransientBook *)transientBook {
    id<REDBookProtocol> book = [self create];
    [self.transactionManager begin];
    [book setName:[transientBook name]];
    [book setCoverURL:[transientBook imageURL]];
    [self.transactionManager commit];

    id<REDAuthorProtocol> author = [self.authorDataAccessObject authorByName:[transientBook authorsName]];
    if (!author) {
        author = [self.authorDataAccessObject create];
        [self.transactionManager begin];
        [author setName:[transientBook authorsName]];
        [self.transactionManager commit];
    }
    [self.transactionManager begin];
    [book setAuthor:author];
    [book setSnippet:[transientBook snippet]];
    
    [[self.bookRepositoryFactory repository] createForUser:self.user book:book callback:^(id<REDBookProtocol> createdBook) {
        
    } error:^(NSError *error) {
        
    }];
    
    return book;
}

#pragma mark - update
-(id<REDBookProtocol>)updateBook:(id<REDBookProtocol>)book withDict:(NSDictionary *)dict {
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
    [self.transactionManager commit];
    
    NSArray * notesDict = dict[@"notes_list"];
    for (NSDictionary * note_dict in notesDict) {
        [self.notesDataAccessObject updateNote:note_dict book:book];
    }
    [self.notesDataAccessObject deleteNotFoundNotesInSequence:notesDict forBook:book];
    
    [self.transactionManager begin];
    [book setRate:[dict[@"rate"] doubleValue]];
    [book setSnippet:dict[@"snippet"]];
    [book setIdentifier:[dict[@"id"] integerValue]];
    if ([[dict objectForKey:@"loved"] isEqual:[NSNull null]] == NO) [book setLoved:[dict[@"loved"] boolValue]];
    [book setPagesValue:[dict[@"pages"] integerValue]];
    [book setPagesReadValue:[dict[@"pages_read"] integerValue]];
    [book setCoverURL:[[dict objectForKey:@"cover_url"] isEqual:[NSNull null]] ? @"" : [dict objectForKey:@"cover_url"]];
    [book setUnprocessed:NO];
    [self.transactionManager commit];
    return book;
}

#pragma mark - queries
-(id)list {
    NSArray * list = [self.rlm_arrayHelper arrayFromResults:[REDRLMBook allObjects]];
    NSMutableArray * notInvalidList = [@[] mutableCopy];
    for (RLMObject * obj in list) {
        if (obj.isInvalidated == NO) {
            [notInvalidList addObject:obj];
        }
    }
    return notInvalidList;
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
    NSArray <id<REDBookProtocol>> * books = [self allBooksSorted];
    NSUInteger booksCompleted = [books filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"completed = 1"]].count;
    return [NSString stringWithFormat:@"%lu/%lu books completed", (unsigned long)booksCompleted, (unsigned long)books.count];
}


@end
