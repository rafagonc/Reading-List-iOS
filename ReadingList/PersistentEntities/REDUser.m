#import "REDUser.h"
#import "UIImage+Blur.h"

@interface REDUser ()

#pragma mark - cache
@property (nonatomic,strong) UIImage *cacheCoverImage;
@property (nonatomic,strong) UIImage *cachePhotoImage;

@end

static NSString * const REDUserPhotoDataKey = @"REDUserPhotoDataKey";
static NSString * const REDUserCoverDataKey = @"REDUserCoverDataKey";


@implementation REDUser

@synthesize cacheCoverImage,cachePhotoImage;

#pragma mark - getters and setters
-(void)setPhoto:(UIImage *)photo {
    NSData * data = UIImagePNGRepresentation(photo);
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:REDUserPhotoDataKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self setCover:photo];
    [self setCachePhotoImage:nil];
}
-(UIImage *)photo {
    if (!self.cachePhotoImage) {
        self.cachePhotoImage = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:REDUserPhotoDataKey]];
    }
    return self.cachePhotoImage;
}
-(void)setCover:(UIImage *)cover {
    NSData * data = UIImagePNGRepresentation([cover applyBlurToImageWithRadius:100.f]);
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:REDUserCoverDataKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self setCacheCoverImage:nil];
}
-(UIImage *)cover {
    if (!self.cacheCoverImage) {
        self.cacheCoverImage = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:REDUserCoverDataKey]];
    }
    return self.cacheCoverImage;
}

#pragma mark - helpers
-(BOOL)hasName {
    return self.name.length > 0;
}
-(BOOL)hasPhoto {
    return self.photo != nil;
}

@end
