//
//  List Books Factory.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDListBooksFactory.h"
#import "REDBookDataAccessObject.h"

@interface REDListBooksFactory ()

@property (setter=injected:) id<REDBookDataAccessObject> bookDataAccesObject;

@end

@implementation REDListBooksFactory

-(NSArray *)outputForMany {
    NSMutableArray *books = [@[] mutableCopy];
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
