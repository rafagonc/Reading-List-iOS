//
//  REDBookCategoryValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDCategoryValidator.h"
#import "REDCategoryProtocol.h"

@implementation REDCategoryValidator

-(BOOL)validate:(id)obj error:(NSError *__autoreleasing *)error {
    id<REDCategoryProtocol> category = (id<REDCategoryProtocol>)obj;
    if (category == nil) {
        if (error) *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Choose a category!"}];
        return NO;
    }
    
    if ([category name].length == 0 || [category name] == nil) {
        if (error) *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"You need to choose a name!"}];
        return NO;
    }
    
    return YES;
}

@end
