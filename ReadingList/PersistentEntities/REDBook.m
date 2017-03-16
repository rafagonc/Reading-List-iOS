#import "REDBook.h"

@interface REDBook ()

// Private interface goes here.

@end

@implementation REDBook

@synthesize cacheImage;

#pragma mark - getters
-(NSUInteger)percentage {
    if (self.pagesValue == 0) return 0;
    return (NSUInteger)((CGFloat)self.pagesReadValue/(CGFloat)self.pagesValue * 100);
}
-(UIImage *)coverImage {
    if (!self.cacheImage) {
        self.cacheImage = [UIImage imageWithData:self.cover];
    }
    return self.cacheImage;
}
-(BOOL)completed {
    if (self.pagesValue == 0) return NO;
    return self.pagesReadValue == self.pagesValue;
}

#pragma mark - setters
-(void)setCoverImage:(UIImage *)coverImage {
    self.cover = UIImagePNGRepresentation(coverImage);
    self.cacheImage = nil;
}

@end
