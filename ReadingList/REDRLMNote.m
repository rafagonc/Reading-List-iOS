//
//  REDRLMNote.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 6/19/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMNote.h"
#import "REDBookDataAccessObject.h"

@interface REDRLMNote ()

@property (setter=injected:) id<REDBookDataAccessObject> bookDataAccessObject;


@end

@implementation REDRLMNote

+(NSArray<NSString *> *)ignoredProperties {
    return @[@"bookDataAccessObject"];
}


-(id<REDBookProtocol>)book {
    return [[self.bookDataAccessObject searchBooksWithString:self.bookName] firstObject];
}


@end
