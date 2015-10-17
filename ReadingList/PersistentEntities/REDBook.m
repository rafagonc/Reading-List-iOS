#import "REDBook.h"

@interface REDBook ()

// Private interface goes here.

@end

@implementation REDBook

@synthesize cacheImage;

#pragma mark - getters
-(NSUInteger)percentage {
    return (NSUInteger)((CGFloat)self.pagesReadValue/(CGFloat)self.pagesValue * 100);
}
-(UIImage *)coverImage {
    if (!self.cacheImage) {
        self.cacheImage = [UIImage imageWithData:self.cover];
    }
    return self.cacheImage;
}
-(BOOL)completed {
    return self.pagesReadValue == self.pagesValue;
}

#pragma mark - setters
-(void)setCoverImage:(UIImage *)coverImage {
    self.cover = UIImagePNGRepresentation(coverImage);
    self.cacheImage = nil;
}

#pragma mark - validation
-(BOOL)validateForInsert:(NSError * _Nullable __autoreleasing *)error {
    BOOL canBeInserted = self.name != nil && self.author != nil && self.pagesValue != 0 && self.category != nil;
    if (!canBeInserted) {
        *error = [NSError errorWithDomain:REDErrorDomain code:101 userInfo:@{NSLocalizedDescriptionKey : @"Values are not valid"}];
    }
    return canBeInserted;
}

@end
