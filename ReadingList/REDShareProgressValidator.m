//
//  REDShareProgressValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 8/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDShareProgressValidator.h"
#import "REDBookProtocol.h"

@implementation REDShareProgressValidator

-(BOOL)validate:(id)obj error:(NSError *__autoreleasing *)error {
    id<REDBookProtocol> book = (id<REDBookProtocol>)obj;
    if ([book name].length == 0 || [book name] == nil) {
        if (error) *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Set a book name to share!"}];
        return NO;
    }
    
    if ([book pagesValue] == 0) {
        if (error) *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Set the total pages before sharing!"}];
        return NO;
    }
    
    return YES;
}

@end
