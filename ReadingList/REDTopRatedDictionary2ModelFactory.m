//
//  REDTopRatedDictionary2ModelFactory.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/16/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDTopRatedDictionary2ModelFactory.h"
#import "REDTopRatedBookImpl.h"

@implementation REDTopRatedDictionary2ModelFactory

-(NSArray *)outputForMany {
    NSMutableArray *books = [@[] mutableCopy];
    for (NSDictionary *book_dict in self.input) {
        REDTopRatedBookImpl *book = [[REDTopRatedBookImpl alloc] init];
        book.bookName = book_dict[@"name"];
        book.authorName = book_dict[@"author"][@"name"];
        book.categoryName = book_dict[@"category"][@"name"];
        book.rating = [book_dict[@"rating"] doubleValue];
        [books addObject:book];
    }
    return books;
}

@end
