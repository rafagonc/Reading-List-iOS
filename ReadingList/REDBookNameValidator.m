//
//  REDBookNameValidator.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 1/25/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDBookNameValidator.h"

@implementation REDBookNameValidator


-(BOOL)validate:(id)obj error:(NSError *__autoreleasing *)error {
    NSString *bookName = (NSString *)obj;
    if (bookName.length == 0 && [bookName isEqualToString:@"Book Name"]) {
        *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey: @"Choose a book name."}];
        return NO;
    }
    return YES;
}

@end
