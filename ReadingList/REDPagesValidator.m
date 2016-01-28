//
//  REDPagesValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/28/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDPagesValidator.h"
#import "NSString+Digits.h"

@implementation REDPagesValidator

-(BOOL)validate:(id)obj error:(NSError *__autoreleasing *)error {
    NSString *pagesText = (NSString *)obj;
    if (pagesText.length == 0) {
        *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Set the pages that your read!"}];
        return NO;
    }
    
    if (![pagesText onlyDigits]) {
        *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Only numbers allowed on pages field!"}];
        return NO;
    }
    
    return YES;
}

@end
