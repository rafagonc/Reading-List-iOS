//
//  REDBookRatngValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 5/21/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDBookRatingValidator.h"
#import "REDBookProtocol.h"

@implementation REDBookRatingValidator

-(BOOL)validate:(id)obj error:(NSError *__autoreleasing *)error {
    id<REDBookProtocol> book = (id<REDBookProtocol>)obj;
    if ([book name] == nil || [[book author] name] == nil || [[book category] name] == nil) {
        *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Incomplete book!"}];
        return NO;
    }
    return YES;
}

@end
