//
//  REDGoodReadsBook.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDTransientBook.h"
#import "REDAuthorDataAccessObject.h"

@interface REDTransientBook ()

#pragma mark - injected
@property (setter=injected:,readonly) id<REDAuthorDataAccessObject> authorDataAccessObject;

@end

@implementation REDTransientBook

#pragma mark - description
-(NSString *)description {
    return [NSString stringWithFormat:@"Title : %@", self.title];
}

#pragma mark - book protcol
-(NSString *)name {
    return self.title;
}
-(id<REDAuthorProtocol>)author {
    id<REDAuthorProtocol> author = [[self.authorDataAccessObject listWithPredicate:[NSPredicate predicateWithFormat:@"name = %@", self.authorsName]] firstObject];
    if (!author) {
        author = [self.authorDataAccessObject create];
        [author setName:self.authorsName];
    }
    return author;
}
-(id<REDCategoryProtocol>)category {
    return nil;
}
-(NSUInteger)pagesValue {
    return 0;
}
-(NSUInteger)pagesReadValue {
    return 0;
}
-(NSUInteger)percentage {
    return 0;
}
-(NSString *)language {
    return nil;
}
-(BOOL)completed {
    return NO;
}

@end
