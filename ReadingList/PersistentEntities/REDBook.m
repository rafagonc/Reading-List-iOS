#import "REDBook.h"

@interface REDBook ()

// Private interface goes here.

@end

@implementation REDBook

#pragma mark - getters
-(NSUInteger)percentage {
    return (NSUInteger)(self.pagesRead/self.pages * 100);
}

@end
