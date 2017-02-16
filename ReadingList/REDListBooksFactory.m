//
//  List Books Factory.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDListBooksFactory.h"
#import "REDBookDataAccessObject.h"
#import "REDTransactionManager.h"

@interface REDListBooksFactory ()

@property (setter=injected1:) id<REDTransactionManager> transactionManager;
@property (setter=injected:) id<REDBookDataAccessObject> bookDataAccesObject;

@end

@implementation REDListBooksFactory

-(NSArray *)outputForMany {
    if (self.input.count == 0) return @[];
    NSMutableArray *books = [@[] mutableCopy];
    
    //delete removed books
    for (id<REDBookProtocol> book in [self.bookDataAccesObject allBooksSorted]) {
        NSDictionary * book_dict = [[self.input filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"book.name LIKE %@", [book name]]] firstObject];
        if (!book_dict) {
            [self.bookDataAccesObject remove:book];
        }
    }
    
    //create and update the others
    for (NSDictionary * dict in self.input) {
        id<REDBookProtocol> book = [[self.bookDataAccesObject searchBooksWithIdentifier:[dict[@"id"] integerValue]] firstObject];
        if (!book) {
            [self.bookDataAccesObject createFromDictionary:dict];
        } else {
            [self.bookDataAccesObject updateBook:book withDict:dict];
        }
    }
    
    return books;
}

@end
