//
//  REDGoodReadsBook.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 12/25/15.
//  Copyright © 2015 Rafael Gonzalves. All rights reserved.
//

#import "REDTransientBook.h"
#import "REDAuthorDataAccessObject.h"
#import "REDTransactionManager.h"

@interface REDTransientBook ()

#pragma mark - injected
@property (setter=injected:) id<REDTransactionManager> transactionManager;
@property (setter=injected:) id<REDAuthorDataAccessObject> authorDataAccessObject;

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
        [self.transactionManager begin];
        [author setName:self.authorsName];
        [self.transactionManager commit];
    }
    return author;
}
-(id<REDCategoryProtocol>)category {
    return nil;
}
-(NSInteger)pagesValue {
    return 0;
}
-(NSInteger)pagesReadValue {
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
