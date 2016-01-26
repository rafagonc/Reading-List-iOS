//
//  REDAuthorValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDAuthorValidator.h"
#import "REDAuthorProtocol.h"

@implementation REDAuthorValidator

-(BOOL)validate:(id)obj error:(NSError *__autoreleasing *)error {
    id<REDAuthorProtocol> author = (id<REDAuthorProtocol>)obj;
    if (author == nil) {
        *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey: @"Choose an author."}];
        return NO;
    }
    return YES;
}

@end
