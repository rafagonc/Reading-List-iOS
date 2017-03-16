//
//  RECategoryNameValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 8/14/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "RECategoryNameValidator.h"

@implementation RECategoryNameValidator

-(BOOL)validate:(id)obj error:(NSError *__autoreleasing *)error {
    if ([obj length] == 0 || obj == nil) {
        if (error) *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"You need to type a name!"}];
        return NO;
    }
    
    return YES;
}

@end
