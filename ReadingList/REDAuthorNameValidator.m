//
//  REDAuthorNameValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/10/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDAuthorNameValidator.h"

@implementation REDAuthorNameValidator

-(BOOL)validate:(id)obj error:(NSError *__autoreleasing *)error {
    NSString *name = (NSString *)obj;
    if (name.length == 0) {
        if (error) *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Fill the author's name"}];
        return NO;
    }
    return YES;
}

@end
