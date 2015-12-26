
//
//  REDGoodReadsFactory.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDGoogleBooksFactory.h"
#import "REDDictionary2ModelFactory_Protected.h"
#import "REDGoogleSearchImageResult.h"
#import "NSDictionary+Validation.h"
#import "REDTransientBook.h"

@implementation REDGoogleBooksFactory

-(id)parse:(NSDictionary *)dict {
    REDTransientBook *transientBook = [[REDTransientBook alloc] init];
    transientBook.title = [[dict rd_validObjectForKey:@"volumeInfo"] rd_validObjectForKey:@"title"];
    transientBook.imageURL = [[[dict rd_validObjectForKey:@"volumeInfo"] rd_validObjectForKey:@"imageLinks"] rd_validObjectForKey:@"thumbnail"];
    transientBook.authorsName = [[[dict rd_validObjectForKey:@"volumeInfo"] rd_validObjectForKey:@"authors"] firstObject] ? [[[dict rd_validObjectForKey:@"volumeInfo"] rd_validObjectForKey:@"authors"] firstObject] : @"Unknown Author";
    return transientBook;
}

@end
