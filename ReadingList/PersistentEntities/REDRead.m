#import "REDRead.h"
#import "REDBookDataAccessObject.h"

@interface REDRead ()

#pragma mark - injected
@property (setter=injected:,readonly) id<REDBookDataAccessObject> bookDataAccessObject;

@end

@implementation REDRead

@synthesize bookDataAccessObject;

#pragma mark - overrides
-(void)awakeFromInsert {
    self.date = [NSDate date];
}

#pragma mark - getters and setters
-(void)setBook:(id<REDBookProtocol>)book {
    self.bookName = [book name];
}
-(id<REDBookProtocol>)book {
    return [[self.bookDataAccessObject listWithPredicate:[NSPredicate predicateWithFormat:@"name MATCHES %@", self.bookName]] firstObject];
}

@end
