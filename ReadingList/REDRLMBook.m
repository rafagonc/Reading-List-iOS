//
//  REDRLMBook.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMBook.h"

@implementation REDRLMBook

#pragma mark - relationships
-(void)setAuthor:(id<REDAuthorProtocol>)author {
    __author = author;
}
-(void)setCategory:(id<REDCategoryProtocol>)category {
    __category = category;
}
-(id<REDAuthorProtocol>)author {
    return __author;
}
-(id<REDCategoryProtocol>)category {
    return __category;
}

#pragma mark - protocol
-(void)setCoverImage:(UIImage *)coverImage {
    _cover = UIImagePNGRepresentation(coverImage);
}
-(UIImage *)coverImage {
    return [UIImage imageWithData:self.cover];
}
-(NSUInteger)percentage {
    if (self.pagesValue == 0) return 0;
    return (NSUInteger)((CGFloat)self.pagesReadValue/(CGFloat)self.pagesValue * 100);
}
-(BOOL)completed {
    if (self.pagesValue == 0) return NO;
    return self.pagesReadValue == self.pagesValue;
}

#pragma mark - override
+(NSArray<NSString *> *)ignoredProperties {
    return @[@"coverImage", @"completed", @"percentage"];
}

@end
