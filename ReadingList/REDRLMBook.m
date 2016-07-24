//
//  REDRLMBook.m
//  ReadingList
//
//  Created by Rafael Gonzalves on 2/2/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

#import "REDRLMBook.h"
#import "REDBookDataAccessObject.h"
#import "REDAuthorDataAccessObject.h"
#import "REDCategoryDataAccessObject.h"
#import "REDBookCoverFlyweightFactory.h"
#import "REDBookCoverFlyweight.h"

@interface REDRLMBook ()

@end

@implementation REDRLMBook

#pragma mark - relationships
-(NSMutableArray<id<REDNotesProtocol>> *)notes {
    return (NSMutableArray<id<REDNotesProtocol>> *)self._notes;
}
-(void)setAuthor:(id<REDAuthorProtocol>)author {
    self._author = author;
}
-(void)setCategory:(id<REDCategoryProtocol>)category {
    self._category = category;
}
-(id<REDAuthorProtocol>)author {
    return self._author;
}
-(id<REDCategoryProtocol>)category {
    return self._category;
}

#pragma mark - protocol
-(void)setCoverImage:(UIImage *)coverImage {
    self.cover = UIImagePNGRepresentation(coverImage);
}
-(UIImage *)coverImage {
    UIImage * coverImage = [REDBookCoverFlyweightFactory coverImageForBook:self];
    if (!coverImage && self.cover) [[REDBookCoverFlyweight sharedFlyweight] addCoverImage:[[UIImage alloc] initWithData:self.cover] forBook:self];
    return [REDBookCoverFlyweightFactory coverImageForBook:self];
}
-(NSUInteger)percentage {
    if (self.pagesValue == 0) return 0;
    return (NSUInteger)((CGFloat)self.pagesReadValue/(CGFloat)self.pagesValue * 100);
}
-(BOOL)completed {
    if (self.pagesValue == 0) return NO;
    return self.pagesReadValue == self.pagesValue;
}
-(BOOL)hasRate {
    return self.rate > 0;
}

#pragma mark - override
+(NSArray<NSString *> *)ignoredProperties {
    return @[@"coverImage", @"completed", @"percentage"];
}

@end
