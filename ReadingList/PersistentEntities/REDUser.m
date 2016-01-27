#import "REDUser.h"

@interface REDUser ()


@end

static NSString * const REDUserPhotoDataKey = @"REDUserPhotoDataKey";

@implementation REDUser

#pragma mark - getters and setters
-(void)setPhoto:(UIImage *)photo {
    NSData * data = UIImagePNGRepresentation(photo);
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:REDUserPhotoDataKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(UIImage *)photo {
    return [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:REDUserPhotoDataKey]];
}

@end
