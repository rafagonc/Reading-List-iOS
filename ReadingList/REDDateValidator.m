//
//  REDDateValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/28/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDDateValidator.h"
#import "NSDate+Escort.h"

@implementation REDDateValidator

-(BOOL)validate:(id)obj error:(NSError *__autoreleasing *)error {
    NSDate *date = (NSDate *)obj;
    if (date == nil) {
        if (error) *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"You need to set the date!"}];
        return NO;
    }
    if ([date isInFuture]) {
        if (error) *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Read it then log it!"}];
        return NO;
    }
    return YES;
}

@end
