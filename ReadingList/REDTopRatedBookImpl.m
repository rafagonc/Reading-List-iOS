//
//  REDTopRatedBook.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 4/16/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDTopRatedBookImpl.h"
#import "REDAuthorDataAccessObject.h"
#import "REDTransactionManager.h"
#import "REDBookProtocol.h"

@interface REDTopRatedBookImpl ()

#pragma mark - injected
@property (setter=injected:) id<REDTransactionManager> transactionManager;
@property (setter=injected:) id<REDAuthorDataAccessObject> authorDataAccessObject;

@end

@implementation REDTopRatedBookImpl

#pragma mark - description
-(NSString *)description {
    return [NSString stringWithFormat:@"Title : %@", self.bookName];
}

#pragma mark - book protcol
-(NSString *)name {
    return self.bookName;
}
-(id<REDAuthorProtocol>)author {
    id<REDAuthorProtocol> author = [[self.authorDataAccessObject listWithPredicate:[NSPredicate predicateWithFormat:@"name = %@", self.authorName]] firstObject];
    if (!author) {
        author = [self.authorDataAccessObject create];
        [self.transactionManager begin];
        [author setName:self.authorName];
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
-(UIImage *)coverImage {
    return nil;
}
-(NSString *)snippet {
    return nil;
}
-(double)rate {
    return 0.0f;
}

@end
