#import "_REDBook.h"
#import "REDBookProtocol.h"

@interface REDBook : _REDBook

<REDBookProtocol>

@property (nonatomic,strong) UIImage *cacheImage;

@end
