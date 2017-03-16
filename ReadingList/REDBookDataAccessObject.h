//
//  REDBookDataAccessObject.h
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDDataAccessObject.h"
#import "REDBookProtocol.h"
#import "REDTransientBook.h"

@protocol REDBookDataAccessObject <REDDataAccessObject>

-(id<REDBookProtocol>)createFromTransientBook:(REDTransientBook *)transientBook;
-(id<REDBookProtocol>)createFromDictionary:(NSDictionary *)dict;
-(id<REDBookProtocol>)updateBook:(id<REDBookProtocol>)book withDict:(NSDictionary *)dict;
-(NSArray <id<REDBookProtocol>> *)allBooksSorted;
-(NSArray <id<REDBookProtocol>> *)searchBooksWithString:(NSString *)name;
-(NSArray <id<REDBookProtocol>> *)searchBooksWithIdentifier:(NSInteger)identifier;
-(NSUInteger)totalPages;
-(NSString *)booksCompletedAndTotalBooks;

@end
