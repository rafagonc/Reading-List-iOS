//
//  REDBookValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/28/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDBookValidator.h"
#import "REDBookProtocol.h"

@implementation REDBookValidator

-(BOOL)validate:(id)obj error:(NSError *__autoreleasing *)error {
    id<REDBookProtocol> book = (id<REDBookProtocol>)obj;
    if (!book) {
        *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"You need to choose a book!"}];
        return NO;
    }
    return YES;
}

@end
